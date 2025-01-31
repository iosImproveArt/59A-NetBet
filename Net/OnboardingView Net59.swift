

import SwiftUI

struct OnboardingViewNet59: View {
    @AppStorage("showOnboarding") var showOnboarding = true
    @State private var selected = 1
    
    var name: String = "Default Name"
        var age: Int = 0
        var isActive: Bool = false
        var scores: [Int] = [10, 20, 30]
        var createdDate: Date = Date()
        
        // Функції
        func printDetails() {
            print("Name: \(name), Age: \(age), Active: \(isActive)")
        }
        
        mutating func incrementAge(by years: Int) {
            age += years
        }
        
        func averageScore() -> Double {
            guard !scores.isEmpty else { return 0.0 }
            let total = scores.reduce(0, +)
            return Double(total) / Double(scores.count)
        }
        
        mutating func toggleActiveState() {
            isActive.toggle()
        }
        
        func isAdult() -> Bool {
            return age >= 18
        }
        
        func greeting() -> String {
            return "Hello, \(name)! Welcome back!"
        }
        
        mutating func addScore(_ newScore: Int) {
            scores.append(newScore)
        }
        
        func formatCreatedDate() -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter.string(from: createdDate)
        }
    
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("onboard \(selected)")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Spacer()
            
            Text("Click anywhere to skip")
                .withFontWNet59(size: 15, weight: .bold)
            HStack(spacing: 1) {
                ForEach(Array(1...5), id: \.self) { index in
                    RoundedRectangle(cornerRadius: .infinity)
                        .frame(width: 35, height: 5)
                        .foregroundColor(index == selected ? .hex("D81D24"): .white)
                }
            }.padding(.bottom)
        }.backgroundNet59(2)
            .onTapGesture {
                if selected < 5 {
                    withAnimation {
                        selected += 1
                    }
                } else {
                    showOnboarding = false
                }
            }
            .opacity(showOnboarding ? 1: 0)
            .animation(.easeInOut, value: showOnboarding)
    }
}

#Preview {
    OnboardingViewNet59()
}
