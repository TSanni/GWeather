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
        let rectangle = RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.1))

        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<hourly.count, id: \.self) { index in
                    VStack {
                        Text("\(hourly[index].temp)" + "°")
                            .fontWeight(.heavy)
                        
                        if hourly[index].pop == "0%" {
                            Text(" ")
                                .fontWeight(.light)

                        } else {
                            Text(hourly[index].pop)
                                .foregroundColor(Color(hue: 0.521, saturation: 0.946, brightness: 0.871))
                                .fontWeight(.light)

                        }
                        
                        Image(systemName: hourly[index].icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(hourly[index].iconColor[0],
                                             hourly[index].iconColor[1],
                                             hourly[index].iconColor[2])
                        
                        Text(hourly[index].time)
                            .fontWeight(.medium)
                            
                    }
                    .padding(.horizontal, 5)
                    .padding(.vertical, 5)
                    .background {
                        hourly[index].time == "12 AM" || hourly[index].time == "12 PM" ? rectangle : nil
                    }
                }
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.black.opacity(0.1))
        }
    }
}

struct HourlyTempsView_Previews: PreviewProvider {
    static var previews: some View {
        
        let hours: [HourlyWeatherModel] = [
            HourlyWeatherModel(temp: "100", time: "7AM", pop: "", icon: "sun.min", iconColor: [.yellow, .yellow, .yellow]),
            HourlyWeatherModel(temp: "100", time: "7AM", pop: "", icon: "sun.min", iconColor: [.yellow, .yellow, .yellow]),
            HourlyWeatherModel(temp: "100", time: "7AM", pop: "", icon: "sun.min", iconColor: [.yellow, .yellow, .yellow]),
            HourlyWeatherModel(temp: "100", time: "7AM", pop: "", icon: "sun.min", iconColor: [.yellow, .yellow, .yellow]),
            HourlyWeatherModel(temp: "100", time: "7AM", pop: "", icon: "sun.min", iconColor: [.yellow, .yellow, .yellow]),
            HourlyWeatherModel(temp: "100", time: "7AM", pop: "", icon: "sun.min", iconColor: [.yellow, .yellow, .yellow]),
            HourlyWeatherModel(temp: "100", time: "7AM", pop: "", icon: "sun.min", iconColor: [.yellow, .yellow, .yellow]),
            HourlyWeatherModel(temp: "100", time: "7AM", pop: "", icon: "sun.min", iconColor: [.yellow, .yellow, .yellow]),
            HourlyWeatherModel(temp: "100", time: "7AM", pop: "", icon: "sun.min", iconColor: [.yellow, .yellow, .yellow]),
            HourlyWeatherModel(temp: "100", time: "7AM", pop: "", icon: "sun.min", iconColor: [.yellow, .yellow, .yellow]),
            HourlyWeatherModel(temp: "100", time: "7AM", pop: "", icon: "sun.min", iconColor: [.yellow, .yellow, .yellow])
        ]
        
        HourlyTempsView( hourly: hours)
        
//            .environmentObject(WeatherViewModel.shared)
    }
}
