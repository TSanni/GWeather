//
//  TodayView.swift
//  GWeather
//
//  Created by Tomas Sanni on 8/29/22.
//

import SwiftUI

struct TodayView: View {
    
    @EnvironmentObject var weather: WeatherViewModel
    let currentWeather: CurrentWeatherModel
    let dailyWeather: DailyWeatherModel //will pass in first item in this array
    
    var body: some View {
        GeometryReader { geo in
            
                VStack(alignment: .leading) {
                    
                    Text(currentWeather.currentTime)
                        .foregroundColor(Color.black)
                        .padding(.bottom, 5)
    //                    .shadow(color: Color.white ,radius: 1)
                    
                    Text("Day \(dailyWeather.maximumTemp)°↑ · Night \(dailyWeather.minimumTemp)°↓")
                        .shadow(color: Color.black, radius: 2)
                    
                    
                    
                    VStack {
                        HStack {
                            Text("\(currentWeather.currentTemp)\(weather.unitLogo)")
                                .font(.system(size: 75, weight: .bold, design: .rounded))
                                .shadow(color: Color.black, radius: 4)
                            
                            Spacer()
                            Image(systemName: currentWeather.icon)
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(currentWeather.iconColor[0], currentWeather.iconColor[1], currentWeather.iconColor[2])
                                .shadow(color: Color.black, radius: 4)

                                .frame(width: 100, height: 100)
                        }
                        .padding(.trailing)
                        
                        HStack {
                            Text("Feels like \(currentWeather.feelsLike)°")

                            Spacer()
                            Text(currentWeather.description.capitalized)
        
                        }
                        .shadow(color: Color.black, radius: 1)
                        .shadow(color: Color.black, radius: 1)
                        .padding(.trailing)
                    }
         
                    Spacer()
                    
                    HourlyTempsView(hourly: weather.hourlyWeather)
                        .shadow(radius: 5)
//                    Spacer()
//                    HourlyBarGraphView(hourly: weather.hourlyWeather)
                    
                    HStack {
                        Image(systemName: "umbrella.fill")
                        Text(dailyWeather.chanceOfPrecipitation + "% chance of precipitation today")
                        Spacer()
                    }
                    .padding()
                    .shadow(color: Color.black, radius: 10)
                    
                }
                .padding()
                .background(weather.todayEnumBackground.getBackgroundColor)
            
        }
        
    }
}












struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        
        
        let today: CurrentWeatherModel = CurrentWeatherModel(currentTime: "12:00 PM",
                                                sunrise: "5:25 AM",
                                                sunset: "5:27 PM",
                                                currentTemp: "100",
                                                feelsLike: "105",
                                                description: "Sunny",
                                                icon: "sun.min",
                                                iconColor: [.yellow, .yellow, .yellow]
        )
        
        
        
        let daily: DailyWeatherModel = DailyWeatherModel(dates: "-", sunrise: "-", sunset: "-", morningTemp: "-", daytimeTemp: "-", eveningTemp: "-", nighttimeTemp: "-", minimumTemp: "-", maximumTemp: "-", morningFeelsLike: "-", daytimeFeelsLike: "-", eveningFeelsLike: "-", nightimeFeelsLike: "-", humidity: "-", windspeed: "-", windDegrees: "-", description: "-", chanceOfPrecipitation: "-", uvIndex: "-", icons: "sun.min", iconColors: [.clear, .clear, .clear])
        
        
        TodayView(currentWeather: today, dailyWeather: daily)
            .previewDevice("iPhone 11 Pro Max")
            .preferredColorScheme(.dark)
            .environmentObject(WeatherViewModel.shared)
        
        TodayView(currentWeather: today, dailyWeather: daily)
            .previewDevice("iPhone SE (3rd generation)")
            .preferredColorScheme(.dark)
            .environmentObject(WeatherViewModel.shared)
        
        TodayView(currentWeather: CurrentWeatherModel.shared, dailyWeather: DailyWeatherModel.shared)
            .previewDevice("iPod touch (7th generation)")
            .preferredColorScheme(.light)
            .environmentObject(WeatherViewModel.shared)
        
    }
}
