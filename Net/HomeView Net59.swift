


import SwiftUI

struct HomeViewNet59: View {
    @AppStorage("secondsWaste") var secondsWaste = 0
    @AppStorage("wasTrained") var wasTrained = false
    
    @AppStorage("favourite") var favourite = ""
    
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
        ScrollView {
                VStack {
                    NavigationLink {
                        TrainingViewNet59(sportType: .cricket)
                    } label: {
                        Image("cricket.label")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .overlay {
                                Image("block.label")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .opacity(wasTrained ? 1: 0)
                            }
                    }.disabled(wasTrained)
                    
                    NavigationLink {
                        TrainingViewNet59(sportType: .golf)
                    } label: {
                        Image("golf.label")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .overlay {
                                Image("block.label")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .opacity(wasTrained ? 1: 0)
                            }
                    }.disabled(wasTrained)
                    
                    NavigationLink {
                        TrainingViewNet59(sportType: .basketball)
                    } label: {
                        Image("basketball.label")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .overlay {
                                Image("block.label")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .opacity(wasTrained ? 1: 0)
                            }
                    }.disabled(wasTrained)
                    
                    NavigationLink {
                        TrainingViewNet59(sportType: .football)
                    } label: {
                        Image("football.label")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .overlay {
                                Image("block.label")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .opacity(wasTrained ? 1: 0)
                            }
                    }.disabled(wasTrained)
                    
                    NavigationLink {
                        TrainingViewNet59(sportType: .tennis)
                    } label: {
                        Image("tennis.label")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .overlay {
                                Image("block.label")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .opacity(wasTrained ? 1: 0)
                            }
                    }.disabled(wasTrained)
                }.padding(.horizontal, 8)
                    .padding(.top)
                    .padding(.horizontal, -12)
            
                NavigationLink {
                    TrainingViewNet59(sportType: SportTypes(rawValue: favourite) ?? .basketball
                    )
                } label: {
                    Image("favourite.workout")
                }.padding(.vertical)
                    .disabled(favourite == "")
                    .grayscale(favourite == "" ? 1 : 0)
                
                statsView
                    .padding(.bottom)
                Spacer()
        }.scrollIndicators(.hidden)
    }
    
    private var statsView: some View {
        VStack(spacing: isSENet59 ? 12: 20) {
            HStack {
                Spacer()
                
                VStack {
                    Image("workouts.label")
                    Image("homefield.label")
                        .overlay {
                            Text(wasTrained ? "1": "0")
                                .withFontWNet59(size: 22.66, weight: .regular)
                        }
                }
                
                Spacer()
                
                VStack {
                    Image("workouttime.label")
                    Image("homefield.label")
                        .overlay {
                            Text("\(secondsWaste / 60) min")
                                .withFontWNet59(size: 22.66, weight: .regular)
                        }
                }
                
                Spacer()
            }
            
            HStack {
                Spacer()
                
                VStack {
                    Image("lastworkout.label")
                    Image("homefield.label")
                        .overlay {
                            Text(wasTrained ? formattedDateString(): "-")
                                .withFontWNet59(size: 22.66, weight: .regular)
                        }
                }
                
                Spacer()
                
                VStack {
                    Image("rating.label")
                    Image("homefield.label")
                        .overlay {
                            Text(wasTrained ? "976/1000": "-/1000")
                                .withFontWNet59(size: 22.66, weight: .regular)
                        }
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentViewNet59(showLoading: false, selectedTab: .home)
}


enum Sports: String {
    case cricket = "Cricket"
    case golf = "golf"
    case tennis = "tennis"
    case basketball = "Basketball"
    case football = "football"
    case pilates = "Pilates"
    case stretch = "Stretch"
}
