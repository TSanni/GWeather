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
    
    var body: some View {
        VStack {
            Text("GWeather")
                .font(.largeTitle)
            List {
                Section("Temp") {
                    Picker("Temperature Units", selection: $temperatureUnits) {
                        Text("Fahrenheit").tag("imperial")
                        Text("Celsius").tag("metric")
                    }
                }
                
                Section("Contact") {
                    SendMailView ()
                }
            }
            
            
        }

    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
            .environmentObject(WeatherViewModel.shared)
    }
}
