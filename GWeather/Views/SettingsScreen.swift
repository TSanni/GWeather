//
//  SettingsScreen.swift
//  GWeather
//
//  Created by Tomas Sanni on 9/15/22.
//

import SwiftUI

struct SettingsScreen: View {
    @State private var temperatureUnits = "imperial"
    @EnvironmentObject var viewModel: WeatherViewModel
    @Environment(\.dismiss) private var dismiss
    @AppStorage("highlight") var highlightedID = 1

    
    var body: some View {
        
        
        Menu {
            Section {
                UnitButton(id: 1, unitName: "Fahrenheit", highlightedID: $highlightedID)
                UnitButton(id: 2, unitName: "Celsius", highlightedID: $highlightedID)
            }

            

        } label: {
//            Text("Settings")
            ZStack {
                LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())

                Image(systemName: "gear")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
            }.padding(.trailing)
        }

        
        
        
//        VStack {
//            Text("GWeather")
//                .font(.largeTitle)
//                .padding()
//            List {
//                Section("Units") {
//                    UnitButton(id: 1, unitName: "Fahrenheit", highlightedID: $highlightedID)
//                    UnitButton(id: 2, unitName: "Celsius", highlightedID: $highlightedID)
//
//                }
//
//                Section("Contact") {
//                    SendMailView ()
//                }
//            }
//
//
//        }.preferredColorScheme(.light)

    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
            .environmentObject(WeatherViewModel.shared)
    }
}

struct UnitButton: View {
    var id: Int
    var unitName: String
    @Binding var highlightedID: Int
    @EnvironmentObject var viewModel: WeatherViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button {
            
            DispatchQueue.main.async {
                if id == 1 {
                    viewModel.manager.startUpdatingLocation()
                    viewModel.units = "imperial"
                } else if id == 2 {
                    viewModel.manager.startUpdatingLocation()
                    viewModel.units = "metric"
                }
            }

            
            highlightedID = id
//            dismiss()

        } label: {
            HStack {
                Text(unitName)
                Spacer()
                Image(systemName: id == highlightedID ? "checkmark.circle.fill" : "checkmark.circle")
            }
        }
    }
}
