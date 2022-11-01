//
//  HourlyTempsView.swift
//  GWeather
//
//  Created by Tomas Sanni on 8/31/22.
//

import SwiftUI

struct HourlyTempsView: View {
    @EnvironmentObject var weather: WeatherViewModel
    let hourly: [HourlyWeatherModel]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<hourly.count, id: \.self) { index in
                    VStack {
                        Text("\(hourly[index].temp)" + "°")
                        
                        if hourly[index].pop == "0%" {
                           Text(" ")
                        } else {
                            Text(hourly[index].pop)
                                .foregroundColor(Color(hue: 0.521, saturation: 0.946, brightness: 0.871))
                        }
                        
                        Image(systemName: hourly[index].icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(hourly[index].iconColor[0],
                                             hourly[index].iconColor[1],
                                             hourly[index].iconColor[2])
                            
                        Text(hourly[index].time)
                    }
                }
            }
        }
    }
}

struct HourlyTempsView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyTempsView( hourly: [HourlyWeatherModel.shared])
            .environmentObject(WeatherViewModel.shared)
    }
}
