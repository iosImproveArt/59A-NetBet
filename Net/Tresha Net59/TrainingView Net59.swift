

import SwiftUI

struct TrainingViewNet59: View {
    @StateObject var vm: TrainViewModel
    @Environment(\.dismiss) var dismiss
    
    init(sportType: SportTypes) {
        _vm = StateObject(wrappedValue: TrainViewModel(sportType: sportType))
    }
    
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
            topBar
            
            Spacer()
            
            if vm.status == .start {
                Image("\(vm.sportType).start")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Image("\(vm.sportType) \(vm.selectedExs)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            Spacer()
            
            Button {
                if vm.status == .start {
                    vm.startTrain()
                } else if vm.selectedExs >= 5 && vm.status == .inProgres {
                    vm.finishTrain()
                } else {
                    vm.selectedExs += 1
                }
            } label: {
                Text(vm.status == .start ? "Start": "Next")
                    .withFontWNet59(size: 18, weight: .medium, color: .hex("FFFFFF"))
                    .padding(.vertical, 11)
                    .padding(.horizontal, 30)
                    .background(Color.hex("D81D24"))
                    .cornerRadius(13.17)
            }
        }.backgroundNet59(3)
            .overlay {
                if vm.status == .finish {
                    finishView
                }
            }
    }
    
    private var topBar: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                HStack {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 22)
                    Text("Back")
                        .withFontWNet59(size: 20, weight: .light)
                }.foregroundStyle(.white)
            }
            
            Spacer()
            
            if vm.status == .inProgres {
                Text("\(vm.selectedExs)/5")
                .withFontWNet59(size: 19.5, weight: .semibold, color: .hex("D81D24"))
                .transition(.move(edge: .trailing))
            } else if vm.status == .start {
                Button {
                    withAnimation {
                        vm.favourite = vm.sportType.rawValue
                    }
                } label: {
                    Image("favourite.button")
                        .renderingMode(.template)
                        .foregroundStyle(vm.favourite == vm.sportType.rawValue ? .pink : .white)
                }
            }
        }.animation(.easeInOut, value: vm.status)
    }
    
    private var finishView: some View {
        VStack(spacing: 25) {
            Spacer()
            
            Text("The workout\nis complete!")
                .withFontWNet59(size: 40, weight: .semibold, color: .hex("D81D24"))
                .padding(.vertical)
            
            HStack {
                Image("rating.label 1")
                Spacer()
                
                RoundedRectangle(cornerRadius: 11)
                    .foregroundColor(.hex("212325"))
                    .overlay {
                        RoundedRectangle(cornerRadius: 11)
                            .stroke(lineWidth: 1)
                            .foregroundColor(.hex("FFA628"))
                    }
                    .frame(width: 100, height: 40)
                    .overlay {
                        Text("987/1000")
                            .withFontWNet59(size: 19.34, weight: .regular)
                    }
            }
            
            HStack {
                Image("time.label")
                Spacer()
                
                RoundedRectangle(cornerRadius: 11)
                    .foregroundColor(.hex("212325"))
                    .overlay {
                        RoundedRectangle(cornerRadius: 11)
                            .stroke(lineWidth: 1)
                            .foregroundColor(.hex("FFA628"))
                    }
                    .frame(width: 100, height: 40)
                    .overlay {
                        Text("\(vm.seconds) sec")
                            .withFontWNet59(size: 19.34, weight: .regular)
                    }
            }
            
            HStack {
                Image("rate.label")
                Spacer()
                
                RoundedRectangle(cornerRadius: 11)
                    .foregroundColor(.hex("212325"))
                    .overlay {
                        RoundedRectangle(cornerRadius: 11)
                            .stroke(lineWidth: 1)
                            .foregroundColor(.hex("FFA628"))
                    }
                    .frame(width: 100, height: 40)
                    .overlay {
                        Text("\(vm.rate)/10")
                            .withFontWNet59(size: 19.34, weight: .regular)
                    }
            }
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Text("Complete the workout")
                    .withFontWNet59(size: 18, weight: .medium, color: .hex("FFFFFF"))
                    .padding(.vertical, 11)
                    .padding(.horizontal, 30)
                    .background(Color.hex("D81D24"))
                    .cornerRadius(13.17)
            }
            .padding(.bottom)
        }.backgroundNet59(4)
    }
}

#Preview {
    TrainingViewNet59(sportType: .basketball)
}

class TrainViewModel: ObservableObject {
    @AppStorage("secondsWaste") var secondsWaste = 0
    @AppStorage("wasTrained") var wasTrained = false
    @AppStorage("favourite") var favourite = ""
    
    enum ViewTypes {
        case start
        case inProgres
        case finish
    }
    
    let rate: Int
    let sportType: SportTypes
    
    @Published var status: ViewTypes = .start
    @Published var seconds = 0
    @Published var selectedExs = 1
    
    init(sportType: SportTypes) {
        self.sportType = sportType
        rate = Int.random(in: 1...10)
        
        if sportType == .stretch {
            startTrain()
        }
    }
    
    func startTrain() {
        status = .inProgres
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] timer in
            guard status == .inProgres else { timer.invalidate(); return }
            
            seconds += 1
        }
    }
    
    func finishTrain() {
        withAnimation {
            status = .finish
        }
        
        secondsWaste += seconds
        wasTrained = true
    }
}


enum SportTypes: String {
    case cricket = "cricket"
    case golf = "golf"
    case tennis = "tennis"
    case basketball = "basketball"
    case football = "football"
    case stretch = "stretch"
}
