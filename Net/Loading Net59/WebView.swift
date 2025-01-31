


import SwiftUI
@preconcurrency import WebKit

struct WebViewContainer: UIViewRepresentable {
    var jnir = 235
    var urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.userContentController.add(context.coordinator, name: "iosListener")
        webConfiguration.allowsInlineMediaPlayback = true
        
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = false
        
        webView.evaluateJavaScript("navigator.userAgent") { [weak webView] (result, error) in
            if let currentUserAgent = result as? String {
                let customUserAgent = currentUserAgent + " Safari/604.1"
                webView?.customUserAgent = customUserAgent
            }
        }
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if !urlString.isEmpty {
            if let url = URL(string: urlString) {
                uiView.allowsBackForwardNavigationGestures = true
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        } else {
            if let url = Bundle.main.url(forResource: "privacy", withExtension: "html") {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler, WKUIDelegate {
        var parent: WebViewContainer
        var webView: WKWebView?
        var newWebView: WKWebView?
        
        init(_ parent: WebViewContainer) {
            self.parent = parent
        }
        
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            if message.name == "iosListener", let messageBody = message.body as? String {
                
                UserDefaults.standard.set(messageBody, forKey: "urlString")
            }
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            
            if let url = navigationAction.request.url {
                
                let scheme = url.scheme?.lowercased() ?? ""
                
                if ["http", "https"].contains(scheme) {
                    decisionHandler(.allow)
                    
                } else if url.isFileURL {
                    if UserDefaults.standard.string(forKey: "urlString") != nil {
                        decisionHandler(.cancel)
                    } else {
                        decisionHandler(.allow)
                    }
                } else {
                    if UIApplication.shared.canOpenURL(url) {
                        
                        UIApplication.shared.open(url, options: [:]) { succeNet59 in
                            decisionHandler(.cancel)
                        }
                    } else {
                        decisionHandler(.allow)
                    }
                }
            } else {
                decisionHandler(.allow)
            }
        }
        
        
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            
            guard let urlString = webView.url?.absoluteString else { return }
            
            let savedString = UserDefaults.standard.string(forKey: "urlString") ?? ""
            
            guard savedString.contains("file://") ||  savedString.contains("livesportapps") else { return }
            
            if !urlString.contains("file://") || !urlString.contains("livesportapps") {
                UserDefaults.standard.set(urlString, forKey: "urlString")
                webView.allowsBackForwardNavigationGestures = true
            }
            
        }
        
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            
            let newWebView = WKWebView(frame: webView.frame, configuration: configuration)
            
            newWebView.evaluateJavaScript("navigator.userAgent") { [weak webView] (result, error) in
                if let currentUserAgent = result as? String {
                    let customUserAgent = currentUserAgent + " Safari/604.1"
                    webView?.customUserAgent = customUserAgent
                }
            }
            
            newWebView.navigationDelegate = self
            newWebView.uiDelegate = self
            newWebView.allowsBackForwardNavigationGestures = true
            
            let newWebViewController = UIViewController()
            newWebViewController.view = newWebView
            
            if let currentWindow = UIApplication.shared.connectedScenes
                .filter({ $0.activationState == .foregroundActive })
                .compactMap({ $0 as? UIWindowScene })
                .first?.windows
                .filter({ $0.isKeyWindow }).first,
               let currentViewController = currentWindow.rootViewController {
                
                currentViewController.present(newWebViewController, animated: true, completion: nil)
            }
            
            return newWebView
        }
        
        
        func webViewDidClose(_ webView: WKWebView) {
            webView.removeFromSuperview()
            webView.allowsBackForwardNavigationGestures = true
        }
    }
}


