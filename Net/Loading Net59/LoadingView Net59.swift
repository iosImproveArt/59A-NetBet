//
//  LoadingView.swift
//  Sg western star
//
//  Created by Uniqit on 16.07.2024.
//
import SwiftUI

struct LoadingViewNet59: View {
    @AppStorage("firstInApp") var firstInApp = true
    var jnir = 235
    @Binding var showView: Bool
    @State var rotation: CGFloat = 0
    
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
            VStack {
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
                
                Image("loading 2")
                    .rotationEffect(.degrees(rotation))
                    .animation(.linear, value: rotation)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 0.004, repeats: true) { timer in
                            guard showView else { timer.invalidate(); return }
                            
                            rotation += 1
                        }
                    }
               
                
                Text("Loading...")
                    .withFontWNet59(size: 30, weight: .medium)
                    .padding(.bottom, 30)
                
                Spacer()
            }.backgroundNet59(2)
            
            PrivacyViewNet59(showLoading: $showView)
                .opacity(firstInApp ? 1: 0)
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    if !firstInApp {
                        showView = false
                    }
                }
            }
        }
    }
    
}


#Preview {
    LoadingViewNet59(showView: .constant(true))
}

