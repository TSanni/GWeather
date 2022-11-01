//
//  TomorrowDetailsView.swift
//  GWeather
//
//  Created by Tomas Sanni on 10/12/22.
//

import SwiftUI

struct TomorrowDetailsView: View {
    let sectionColor = Color.black
    let tomorrow: DailyWeatherModel
    
    var body: some View {
        List {
            Section("Details") {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Humidity")
                        Text("UV index")
                        Text("Sunrise/sunset")
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text(tomorrow.humidity + "%")
                        Text(tomorrow.uvIndex)
                        Text("\(tomorrow.sunrise), \(tomorrow.sunset)")
                    }
                }
            }
            .listRowBackground(sectionColor.opacity(0.2))
            
            
            Section("Tomorrow's Temperatures") {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Morning ")
                        Text("Daytime ")
                        Text("Evening ")
                        Text("Nighttime ")
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text(tomorrow.morningTemp + "°")
                        Text(tomorrow.daytimeTemp + "°")
                        Text(tomorrow.eveningTemp + "°")
                        Text(tomorrow.nighttimeTemp + "°")
                    }
                }
            }
            .listRowBackground(sectionColor.opacity(0.2))
            
            Section("Tomorrow's Feel Like Temperatures") {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Morning ")
                        Text("Daytime ")
                        Text("Evening ")
                        Text("Nighttime ")
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text(tomorrow.morningFeelsLike + "°")
                        Text(tomorrow.daytimeFeelsLike + "°")
                        Text(tomorrow.eveningFeelsLike + "°")
                        Text(tomorrow.nightimeFeelsLike + "°")
                    }
                }
            }
            .listRowBackground(sectionColor.opacity(0.2))
        }
        .foregroundColor(.white)
    }
}

struct TomorrowDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TomorrowDetailsView(tomorrow: DailyWeatherModel.shared)
    }
}
