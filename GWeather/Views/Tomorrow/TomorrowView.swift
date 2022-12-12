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
    let tomorrow: TomorrowWeatherModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(tomorrow.date)
                .font(.title2)
                .foregroundColor(Color.black)
                .shadow(color: Color.white ,radius: 1)
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Day \(tomorrow.highTemp)°↑ · Night \(tomorrow.lowTemp)°↓")
                    Text(tomorrow.weatherDescription.capitalized)
                        .font(.title)
                }
                Spacer()
                
                Image(systemName: weather.dailyWeather[1].icons)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(tomorrow.iconColor[0], tomorrow.iconColor[1], tomorrow.iconColor[2])
                    .frame(width: 75, height: 75)
                    .padding(.trailing)
            }
            
            Spacer()
            
//            HourlyTempsView()
            TomorrowDetailsView(tomorrow: weather.dailyWeather[1])
                .scrollContentBackground(.hidden)

            
            HStack {
                Image(systemName: "umbrella.fill")
                Text(tomorrow.chanceOfPrecipitation + "% chance of precipitation tomorrow")
                    .font(.headline)

            }
            .padding()
            .shadow(color: Color.black, radius: 10)
    
        }
        .padding()
        .background(K.Colors.cloudyBlue)
    }
}

struct TomorrowView_Previews: PreviewProvider {
    static var previews: some View {
        TomorrowView(tomorrow: TomorrowWeatherModel.shared)
            .environmentObject(WeatherViewModel.shared)
    }
}
