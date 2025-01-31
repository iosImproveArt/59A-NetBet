//
//  DayliStrerchView.swift
//  Sumo sport
//
//  Created by Improve on 11.12.2024.
//

import SwiftUI

struct DayliStrerchView: View {
    @AppStorage("wasTrained") var wasTrained = false
    
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
        VStack {
            Spacer()
            
            Image("stretch.start")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            HStack {
                NavigationLink {
                    TrainingViewNet59(sportType: .stretch)
                } label: {
                    Text("Start")
                        .withFontWNet59(size: 18, weight: .medium, color: .hex("FFFFFF"))
                        .padding(.vertical, 11)
                        .padding(.horizontal, 30)
                        .background(Color.hex("D81D24"))
                        .cornerRadius(13.17)
                }.grayscale(wasTrained ? 1: 0)
                    .disabled(wasTrained)
                
                if wasTrained {
                    Text("Come back tomorrow")
                        .withFontWNet59(size: 15, weight: .bold)
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    ContentViewNet59(showLoading: false, selectedTab: .stretch)
}
