

import SwiftUI

struct QuotesViewNet59: View {
    let quotes: [String: String] = [
        "The only way to prove you are a good sport is to lose." : "Ernie Banks",
        "Success is where preparation and opportunity meet." : "Bobby Unser",
        "Do what you can, with what you have, where you are." : "Theodore Roosevelt",
        "The future belongs to those who believe in the beauty of their dreams." : "Eleanor Roosevelt",
        "It does not matter how slowly you go as long as you do not stop." : "Confucius",
        "Don’t watch the clock; do what it does. Keep going." : "Sam Levenson",
        "Opportunities don't happen, you create them." : "Chris Grosser",
        "Act as if what you do makes a difference. It does." : "William James",
        "Success is not the key to happiness. Happiness is the key to success." : "Albert Schweitzer",
        "The only limit to our realization of tomorrow is our doubts of today." : "Franklin D. Roosevelt",
        "Believe you can and you’re halfway there." : "Theodore Roosevelt",
        "The only thing standing between you and your goal is the story you keep telling yourself." : "Jordan Belfort",
        "Happiness is not something ready made. It comes from your own actions." : "Dalai Lama",
        "Do not dwell in the past, do not dream of the future, concentrate the mind on the present moment." : "Buddha",
        "What lies behind us and what lies before us are tiny matters compared to what lies within us." : "Ralph Waldo Emerson",
        "Hardships often prepare ordinary people for an extraordinary destiny." : "C.S. Lewis",
        "It is not length of life, but depth of life." : "Ralph Waldo Emerson",
        "It is during our darkest moments that we must focus to see the light." : "Aristotle",
        "You are never too old to set another goal or to dream a new dream." : "C.S. Lewis",
        "The secret of getting ahead is getting started." : "Mark Twain",
        "Success usually comes to those who are too busy to be looking for it." : "Henry David Thoreau",
        "What you get by achieving your goals is not as important as what you become by achieving your goals." : "Zig Ziglar",
        "Don’t be pushed by your problems. Be led by your dreams." : "Ralph Waldo Emerson",
        "Do what you love and the money will follow." : "Marsha Sinetar",
        "Perfection is not attainable, but if we chase perfection we can catch excellence." : "Vince Lombardi",
        "You miss 100% of the shots you don’t take." : "Wayne Gretzky",
        "I find that the harder I work, the more luck I seem to have." : "Thomas Jefferson",
        "Don’t limit your challenges. Challenge your limits." : "Jerry Dunn",
        "Everything you’ve ever wanted is on the other side of fear." : "George Addair"
    ]
    
    @State var timer: Timer?
    @State var selectedQuote: Dictionary<String, String>.Element? = ("", "")
    
    var brand: String = "Unknown"
    var model: String = "Unknown"
    var year: Int = 2000
    var mileage: Double = 0.0
    var fuelLevel: Double = 100.0
    var isElectric: Bool = false
    var owner: String = "No Owner"
    
    func carInfo() -> String {
        return "\(brand) \(model) (\(year))"
    }
    
    func needsMaintenance() -> Bool {
        return mileage > 100_000
    }
    
    mutating func drive(distance: Double) {
        mileage += distance
        fuelLevel -= distance * (isElectric ? 0.2 : 0.08)
        if fuelLevel < 0 { fuelLevel = 0 }
    }
    
    mutating func refuel(amount: Double) {
        fuelLevel += amount
        if fuelLevel > 100 { fuelLevel = 100 }
    }
    
    func isClassicCar() -> Bool {
        return year < 1990
    }
    
    func ownerInfo() -> String {
        return "This car belongs to \(owner)."
    }
    
    var body: some View {
        VStack(alignment: .trailing) {
            Spacer()
            
            if let selectedQuote = selectedQuote {
                HStack {
                    Text("\"\(selectedQuote.key)\"")
                        .withFontWNet59(size: 22, weight: .semibold)
                        .padding(.bottom, 40)
                    
                    Spacer()
                }.padding(.horizontal)
                Text("- \(selectedQuote.value)")
                    .withFontWNet59(size: 16.5, weight: .semibold, color: .hex("D81D24"))
                    .padding(.trailing, 20)
            }
            
            Spacer()
            
            NavigationLink {
                PrivacyViewNet59(showLoading: .constant(true), fromMainView: true)
            } label: {
                Text("Privacy Policy")
                    .withFontWNet59(size: 18, weight: .light, color: .white)
            }.frame(maxWidth: .infinity)
                .padding(.bottom)
        }.onAppear {
            selectedQuote = quotes.randomElement()!
            timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { _ in
                withAnimation(.easeInOut(duration: 0.6)) {
                    selectedQuote = nil
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    withAnimation(.easeInOut(duration: 1)) {
                        selectedQuote = quotes.randomElement()!
                    }
                }
            })
        }
        .onDisappear {
            timer?.invalidate()
            timer = nil
        }
    }
}

#Preview {
    ContentViewNet59(showLoading: false, selectedTab: .quotes)
}

