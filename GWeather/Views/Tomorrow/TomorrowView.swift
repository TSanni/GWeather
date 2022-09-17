//
//  TomorrowView.swift
//  GWeather
//
//  Created by Tomas Sanni on 9/1/22.
//

import SwiftUI

struct TomorrowView: View {
    let purpleGradient = LinearGradient(colors: [.purple, .indigo], startPoint: .top, endPoint: .bottom)
    @EnvironmentObject var weather: WeatherViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(weather.tomorrowWeather.date)
                .font(.title2)
                .foregroundColor(Color.black)
                .shadow(color: Color.white ,radius: 1)
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Day \(weather.tomorrowWeather.highTemp)°↑ · Night \(weather.tomorrowWeather.lowTemp)°↓")
                    Text(weather.tomorrowWeather.weatherDescription.capitalized)
                        .font(.title)
                }
                Spacer()
                
                Image(systemName: weather.dailyWeather[1].icons)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(weather.tomorrowWeather.iconColor[0], weather.tomorrowWeather.iconColor[1], weather.tomorrowWeather.iconColor[2])
                    .frame(width: 75, height: 75)
                    .padding(.trailing)
            }
            
            Spacer()
            
//            HourlyTempsView()
            
            HStack {
                Text(weather.tomorrowWeather.chanceOfPrecipitation + "% chance of precipitation tomorrow")
            }
            .padding()
            .shadow(color: Color.black, radius: 10)

            
        }
        .padding()
        .background(purpleGradient)
    }
}

struct TomorrowView_Previews: PreviewProvider {
    static var previews: some View {
        TomorrowView()
            .environmentObject(WeatherViewModel.shared)
    }
}
