
import SwiftUI

struct ProfileViewNet59: View {
    @Environment(\.dismiss) var dismiss
    @State var userPhoto = ""
    @State var userName = ""
    @State var userAge = ""
    @State var userWeight = ""
    
    @State var showActionSheetBB = false
    @State private var showImagePickerBB = false
    @State private var showCameraPickerBB = false
    @State var ev = false
    @FocusState var textfield
    @State var showAlert = false
    
    let fieldsColor = Color.hex("B35C5C")
    
    @State private var showList = false
    
    let listOfSports = ["football", "volleyball", "basketball", "golf", "swimming", "volleyball", "cycling", "gym", "boxing", "fencing", "cricket"]
    
    @AppStorage("secondsWaste") var secondsWaste = 0
    @AppStorage("wasTrained") var wasTrained = false
    @AppStorage("favourite") var favourite = ""
    @AppStorage("kkcal") var kkcal = 0
    @AppStorage("selectedSport") var selectedSport = "golf"
    
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
                HStack(alignment: .bottom) {
                    Button {
                        showActionSheetBB = true
                    } label: {
                        Group {
                            if userPhoto.isEmpty {
                                Image("user.label")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 120, maxHeight: 120)
                            } else {
                                Image(uiImage: UIImage(data: Data(base64Encoded: userPhoto)!)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                    .frame(maxWidth: 160, maxHeight: 160)
                            }
                        }.padding(.top)
                    }.onAppear {
                        userPhoto = UserDefaults.standard.string(forKey: "userPhoto") ?? ""
                        userName = UserDefaults.standard.string(forKey: "userName") ?? ""
                        userAge = UserDefaults.standard.string(forKey: "userAge") ?? ""
                        
                        userWeight = UserDefaults.standard.string(forKey: "userWeight") ?? ""
                    }.padding(.top, isSENet59 ? 0: 30)
                    
                    Spacer()
                    
                        HStack(spacing: 8) {
                            
                            Image("textfield")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 40)
                                .overlay {
                                    TextField("Name", text: $userName)
                                        .padding(.horizontal, 15)
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 6)
                                }
                                .padding(.trailing, 30)
                        }.padding(.bottom)
                }
                
                selectSportView
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Age")
                        .withFontWNet59(size: 22, weight: .regular)
                        .padding(.horizontal)
                    TextField("Your Age...", text: $userAge)
                        .padding(.horizontal)
                        .padding(.vertical, 14)
                        .background {
                            Color.hex("212325")
                        }
                        .cornerRadius(12)
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading) {
                    Text("Weight")
                        .withFontWNet59(size: 22, weight: .regular)
                        .padding(.horizontal)
                    
                    TextField("Your Weight...", text: $userWeight)
                        .padding(.horizontal)
                        .padding(.vertical, 14)
                        .background {
                            Color.hex("212325")
                        }
                        .cornerRadius(12)
                        .foregroundColor(.white)
                }.padding(.top)
                
                HStack {
                    Button {
                        guard isValidWeightAndAge(), !userPhoto.isEmpty else { showAlert = true; return }
                        UserDefaults.standard.set(userPhoto, forKey: "userPhoto")
                        UserDefaults.standard.set(userName, forKey: "userName")
                        UserDefaults.standard.set(userAge, forKey: "userAge")
                        UserDefaults.standard.set(userWeight, forKey: "userWeight")
                        showAlert = true
                    } label: {
                        Image("profile.save")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .overlay {
                                Text("Save")
                                    .withFontWNet59(size: 18, weight: .medium, color: .hex("FFFFFF"))
                            }
                    }
                    
                    Button {
                        UserDefaults.standard.set("", forKey: "userPhoto")
                        UserDefaults.standard.set("", forKey: "userName")
                        UserDefaults.standard.set("", forKey: "userAge")
                        UserDefaults.standard.set("", forKey: "userWeight")
                        userName = ""
                        userAge = ""
                        userPhoto = ""
                        userWeight = ""
                        selectedSport = "cricket"
                        secondsWaste = 0
                        wasTrained = false
                        favourite = ""
                        kkcal = 0
                    } label: {
                        Image("profile.save")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .overlay {
                                Text("Delete")
                                    .withFontWNet59(size: 18, weight: .medium, color: .hex("FFFFFF"))
                            }
                    }
                }
                .padding(.top)
            }.padding(.horizontal)
                .padding(.bottom)
            
        }.gradientTopAndBottom()
            .backgroundNet59(3)
        .animation(.easeInOut, value: textfield)
        .actionSheet(isPresented: $showActionSheetBB) {
            ActionSheet(title: Text(""), buttons: [
                .default(Text("Camera")) {
                    showCameraPickerBB = true
                },
                .default(Text("Photo Library")) {
                    showImagePickerBB = true
                },
                .cancel() // Кнопка скасування
            ])
        }
        .overlay(alignment: .topLeading) {
            Button {
                dismiss()
            } label: {
                Image("arrow.back")
            }.padding(.leading, 5)
        }
        .sheet(isPresented: $showImagePickerBB) {
            ImagePickerViewBB(showImagePicker: self.$showImagePickerBB) { image in
                if let image = image {
                    if let compressedData = image.jpegData(compressionQuality: 0.01) {
                        self.userPhoto = compressedData.base64EncodedString()
                    }
                }
            }.edgesIgnoringSafeArea(.all)
        }
        .sheet(isPresented: $showCameraPickerBB) {
            CameraPickerView(showImagePicker: self.$showCameraPickerBB) { image in
                if let image = image {
                    if let compressedData = image.jpegData(compressionQuality: 0.01) {
                        self.userPhoto = compressedData.base64EncodedString()
                    }
                }
            }.edgesIgnoringSafeArea(.all)
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(isValidWeightAndAge() ? "Saved!": "Oops!"),
                message: Text(isValidWeightAndAge() ? "Successful data saving":  "Please enter a valid age or weight (photo)."),
                dismissButton: .default(Text("OK"))
            )
        }
        
    }
    
    private var selectSportView: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Favorite Sport")
                .withFontWNet59(size: 22, weight: .regular)
                .padding(.horizontal)
            
            VStack(spacing: 25) {
                Text(selectedSport.capitalized)
                    .withFontWNet59(size: 16, weight: .regular)
                    .frame(maxWidth: .infinity)
                    .overlay {
                        HStack {
                            Image("\(selectedSport).image")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 25)
                            Spacer()
                            
                            Image("triangle")
                                .rotationEffect(.degrees(showList ? 180: 0))
                        }
                    }
                
                if showList {
                    ForEach(listOfSports.filter { $0 != selectedSport }, id: \.self) { sport in
                        Text(sport)
                            .withFontWNet59(size: 16, weight: .regular)
                            .frame(maxWidth: .infinity)
                            .overlay {
                                HStack {
                                    Image("\(sport).image")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 25)
                                    Spacer()
                                }
                            }
                            .onTapGesture {
                                withAnimation {
                                    selectedSport = sport
                                    showList = false
                                }
                            }
                    }
                }
            }.padding()
                .background {
                    Color.hex("212325")
                }
                .cornerRadius(12)
                .onTapGesture {
                    withAnimation {
                        showList.toggle()
                    }
                }
        }.padding(.top)
    }
    
    private func isValidWeightAndAge() -> Bool {
        guard let weigt = Int(userWeight), Array(1...300).contains(weigt) else { return false }
        guard let age = Int(userAge), Array(1...100).contains(age) else { return false }
        return true
    }
}

#Preview {
    ContentViewNet59(showLoading: false, selectedTab: .profile)
}


