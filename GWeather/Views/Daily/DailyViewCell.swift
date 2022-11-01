//
//  DailyViewCell.swift
//  GWeather
//
//  Created by Tomas Sanni on 9/2/22.
//

import SwiftUI

struct DailyViewCell: View {
    @EnvironmentObject var weather: WeatherViewModel
    @State private var showDetails = false
    let daily: DailyWeatherModel
    let dateIsToday: Bool
    
    let grayColor = Color(red: 0.361, green: 0.404, blue: 0.46)
    
    var body: some View {
        
        VStack {
            
            ShowDetailsButton(showDetails: $showDetails, daily: daily, dateIsToday: dateIsToday)

            if showDetails {
                
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Wind")
                        Text("Humidity")
                        Text("UV index")
                        Text("Sunrise/sunset")
                    }.foregroundColor(grayColor)
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 5) {
//                        Text(daily.windspeed + " mph")
                        Text(daily.windspeed + (weather.units == "imperial" ? " mph" : " m/s")  )
                        Text(daily.humidity + "%")
                        Text(daily.uvIndex)
                        Text("\(daily.sunrise), \(daily.sunset)")
                    }
                    
                    Spacer()
                }
                
                
                
                
                
//                VStack(alignment: .leading, spacing: 10) {
//                    HStack {
//                        Text("Wind").foregroundColor(.gray)
//                        Spacer()
//                        Text("\(daily.windspeed)")
//                    }
//                    HStack {
//                        Text("Humidity").foregroundColor(.gray)
//                        Spacer()
//                        Text("\(daily.humidity)")
//                    }
//                    HStack {
//                        Text("UV index").foregroundColor(.gray)
//                        Spacer()
//                        Text("\(daily.uvIndex)")
//                    }
//                    HStack {
//                        Text("Sunrise/sunset").foregroundColor(.gray)
//                        Spacer()
//                        Text("\(daily.sunrise), \(daily.sunset)")
//                    }
//                }.padding(.vertical)
                
            }
        }
    }
}

struct DailyViewCell_Previews: PreviewProvider {
    static var previews: some View {
        DailyViewCell(daily: DailyWeatherModel.shared, dateIsToday: false)
        //            .preferredColorScheme(.dark)
        
        DailyViewCell(daily: DailyWeatherModel.shared, dateIsToday: false)
        //            .preferredColorScheme(.light)
        
    }
}

struct ShowDetailsButton: View {
    @Binding var showDetails: Bool
    let daily: DailyWeatherModel
    let dateIsToday: Bool
    let grayColor = Color(red: 0.361, green: 0.404, blue: 0.46)

    
    var body: some View {
        Button {
            withAnimation {
                showDetails.toggle()
            }
            
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    if dateIsToday {
                        Text("Today")
                    } else {
                        Text(daily.dates)

                    }
                    
                    Text(daily.description.capitalized)
                        .foregroundColor(grayColor)
                }
                
                Spacer()
                
                HStack {
                    
                    if daily.chanceOfPrecipitation != "0" {
                        Text(daily.chanceOfPrecipitation + "%")
                            .foregroundColor(Color(hue: 0.521, saturation: 0.946, brightness: 0.871))

                    }
                    Image(systemName: daily.icons)
                        .resizable()
                        .foregroundStyle(daily.iconColors[0], daily.iconColors[1], daily.iconColors[2])
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    VStack {
                        Text(daily.maximumTemp + "°")
                        Text(daily.minimumTemp + "°")
                            .foregroundColor(grayColor)
                    }
                }
            }
        }
    }
}
