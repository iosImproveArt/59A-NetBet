

import Foundation
import SwiftUI


extension View {
    var isSENet59: Bool {
        return UIScreen.main.bounds.height < 680
    }
    
    var screenNet59: CGRect {
        return UIScreen.main.bounds
    }
    
    func withFontWNet59(size: CGFloat, weight: Font.Weight, color: Color = .white) -> some View {
        return self
            .font(.system(size: size, weight: weight))
            .foregroundStyle(color)
    }
    
    func backgroundNet59(_ number: Int, padding: CGFloat = 12) -> some View {
        self
            .padding(padding)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("bg \(number)")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
            )
            .navigationItemsCloseNet59()
    }
    
    func navigationItemsCloseNet59() -> some View {
        self
            .navigationBarBackButtonHidden()
            .navigationTitle("")
            .navigationBarHidden(true)
    }
}

extension Color {
    static func hex(_ hex: String) -> Color {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        return Color.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }

extension ScrollView {
    func gradientTopAndBottom(height: CGFloat = 10) -> some View {
        self
            .mask(
                VStack(spacing: 0) {

                    // Top gradient
                    LinearGradient(gradient:
                       Gradient(
                           colors: [Color.black.opacity(0), Color.black]),
                                   startPoint: .top, endPoint: .bottom
                       )
                       .frame(height: height)

                    // Middle
                    Rectangle().fill(Color.black)

                    // Bottom gradient
                    LinearGradient(gradient:
                       Gradient(
                           colors: [Color.black, Color.black.opacity(0)]),
                                   startPoint: .top, endPoint: .bottom
                       )
                       .frame(height: height)
                }
             )
    }
}
