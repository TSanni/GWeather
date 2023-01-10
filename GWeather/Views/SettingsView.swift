//
//  SettingsView.swift
//  GWeather
//
//  Created by Tomas Sanni on 11/1/22.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("highlight") var highlightedID = 1
    @EnvironmentObject var viewModel: WeatherViewModel


    
    var body: some View {
        List {
            
            Section("Units") {
                UnitButton(id: 1, unitName: "Fahrenheit", highlightedID: $highlightedID)
                UnitButton(id: 2, unitName: "Celsius", highlightedID: $highlightedID)
            }
            
            Section("Support") {
                SendMailView()
            }
        }
//        .background(viewModel.backgroundColor)
        .scrollContentBackground(.hidden)
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
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
            dismiss()
            
        } label: {
            HStack {
                Text(unitName)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: id == highlightedID ? "checkmark.circle.fill" : "checkmark.circle")
            }
        }
    }
}
