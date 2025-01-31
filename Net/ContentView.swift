


import SwiftUI

struct ContentViewNet59: View {
    @AppStorage("wasTrained") var wasTrained = false
    @State var showLoading = true
    @State var selectedTab: Tabs = .home
    
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
        ZStack {
            
            NavigationView {
                ZStack(alignment: .bottom) {
                    VStack {
                        topBar
                        
                        Group {
                            switch selectedTab {
                            case .home:
                                HomeViewNet59()
                            case .profile:
                                KcalView()
                            case .quotes:
                                QuotesViewNet59()
                            case .stretch:
                                DayliStrerchView()
                            }
                        }
                        
                        tapBar
                            
                    }.backgroundNet59(2)
                        .ignoresSafeArea(.keyboard)
                   
                }
            }
            
            OnboardingViewNet59()
            
            LoadingViewNet59(showView: $showLoading)
                .opacity(showLoading ? 1: 0)
                .onChange(of: showLoading) { newValue in
                    AppDelegate.orientationLock = .portrait
                }
        }
    }
    
    private var topBar: some View {
        HStack {
            Text(wasTrained ? "Training rate: 3/10": "Training rate: -/10")
                .withFontWNet59(size: 14.2, weight: .light)
                .frame(width: 130)

            Spacer()
            
            Text(formattedDateString())
                .withFontWNet59(size: 14.2, weight: .light)
        }
    }
    private var tapBar: some View {
        HStack {
            Button {
                withAnimation {
                    selectedTab = .home
                }
            } label: {
                ZStack {
                    if selectedTab == .home {
                        Circle()
                            .foregroundColor(.white)
                            .frame(height: 57)
                            .transition(.scale)
                    } else {
                        Circle()
                            .foregroundColor(.white)
                            .frame(height: 57)
                            .opacity(0)
                    }
                    
                    Image("tab 1")
                        .renderingMode(.template)
                        .offset(y: 3)
                        .foregroundColor(selectedTab == .home ? .hex("212325"): .white)
                }
            }
            
            Spacer()
            
            Button {
                withAnimation {
                    selectedTab = .profile
                }
            } label: {
                ZStack {
                    if selectedTab == .profile {
                        Circle()
                            .foregroundColor(.white)
                            .frame(height: 57)
                            .transition(.scale)
                    } else {
                        Circle()
                            .foregroundColor(.white)
                            .frame(height: 57)
                            .opacity(0)
                    }
                    
                    Image("tab 2")
                        .renderingMode(.template)
                        .offset(y: 3)
                        .foregroundColor(selectedTab == .profile ? .hex("212325"): .white)
                    
                }
            }
            
            Spacer()
            
            Button {
                withAnimation {
                    selectedTab = .quotes
                }
            } label: {
                ZStack {
                    if selectedTab == .quotes {
                        Circle()
                            .foregroundColor(.white)
                            .frame(height: 57)
                            .transition(.scale)
                    } else {
                        Circle()
                            .foregroundColor(.white)
                            .frame(height: 57)
                            .opacity(0)
                    }
                    
                    Image("tab 3")
                        .renderingMode(.template)
                        .offset(y: 3)
                        .foregroundColor(selectedTab == .quotes ? .hex("212325"): .white)
                    
                }
            }
            
            Spacer()
            
            Button {
                withAnimation {
                    selectedTab = .stretch
                }
            } label: {
                ZStack {
                    if selectedTab == .stretch {
                        Circle()
                            .foregroundColor(.white)
                            .frame(height: 57)
                            .transition(.scale)
                    } else {
                        Circle()
                            .foregroundColor(.white)
                            .frame(height: 57)
                            .opacity(0)
                    }
                    
                    Image("tab 4")
                        .renderingMode(.template)
                        .offset(y: 3)
                        .foregroundColor(selectedTab == .stretch ? .hex("212325"): .white)
                }
            }
        }
        .padding(6)
        .padding(.horizontal, 20)
        .background(Color.hex("212325"))
        .cornerRadius(55)
        .padding(.bottom)
    }
}

#Preview {
    ContentViewNet59(showLoading: false)
}


enum Tabs {
    case home
    case profile
    case quotes
    case stretch
}

func formattedDateString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    let dateString = dateFormatter.string(from: Date())
    return dateString
}



