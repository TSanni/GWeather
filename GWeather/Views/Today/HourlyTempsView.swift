//
//  HourlyTempsView.swift
//  GWeather
//
//  Created by Tomas Sanni on 8/31/22.
//

import SwiftUI

struct HourlyTempsView: View {
    @EnvironmentObject var weather: WeatherViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<weather.hourlyWeather.count, id: \.self) { index in
                    VStack {
                        Text(weather.hourlyWeather[index].temp + "°")
                        Text(weather.hourlyWeather[index].pop)
                            .foregroundColor(Color(hue: 0.521, saturation: 0.946, brightness: 0.871))
                        Image(systemName: weather.hourlyWeather[index].icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(weather.hourlyWeather[index].iconColor[0],
                                             weather.hourlyWeather[index].iconColor[1],
                                             weather.hourlyWeather[index].iconColor[2])
                            
                        Text(weather.hourlyWeather[index].time)
                    }
                }
            }
        }
    }
}

struct HourlyTempsView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyTempsView()
            .environmentObject(WeatherViewModel.shared)
    }
}
