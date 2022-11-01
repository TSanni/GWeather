//
//  WeatherModels.swift
//  GWeather
//
//  Created by Tomas Sanni on 9/14/22.
//

import Foundation
import SwiftUI

struct CurrentWeatherModel {
    let currentTime: String //current time
    let sunrise: String
    let sunset: String
    let currentTemp: String
    let feelsLike: String
    let description: String
    let icon: String
    let iconColor: [Color]
    
    static let shared = CurrentWeatherModel(currentTime: "-",
                                            sunrise: "-",
                                            sunset: "-",
                                            currentTemp: "-",
                                            feelsLike: "-",
                                            description: "-",
                                            icon: "sun.min",
                                            iconColor: [.clear, .clear, .clear]
    )
}


struct TomorrowWeatherModel {
    
    static let shared = TomorrowWeatherModel(date: "-", highTemp: "-", lowTemp: "-", weatherDescription: "-", icon: "sun.min", iconColor: [.clear,.clear,.clear], chanceOfPrecipitation: "-")
    
    let date: String
    let highTemp: String
    let lowTemp: String
    let weatherDescription: String
    let icon: String
    let iconColor: [Color]
    let chanceOfPrecipitation: String
}

struct HourlyWeatherModel: Identifiable {
    let temp: String
    let time: String
    let pop: String
    let icon: String
    let iconColor: [Color]
    
    var id = UUID()
    
    static let shared = HourlyWeatherModel(temp: "-", time: "-", pop: "-", icon: "sun.min", iconColor: [.clear, .clear, .clear])
}


struct DailyWeatherModel: Identifiable {
    var id = UUID()
    
    static let shared = DailyWeatherModel(dates: "-", sunrise: "-", sunset: "-", morningTemp: "-", daytimeTemp: "-", eveningTemp: "-", nighttimeTemp: "-", minimumTemp: "-", maximumTemp: "-", morningFeelsLike: "-", daytimeFeelsLike: "-", eveningFeelsLike: "-", nightimeFeelsLike: "-", humidity: "-", windspeed: "-", windDegrees: "-", description: "-", chanceOfPrecipitation: "-", uvIndex: "-", icons: "sun.min", iconColors: [.clear, .clear, .clear])
    
    
    
    let dates: String //all dates
    let sunrise: String
    let sunset: String
    
    let morningTemp: String
    let daytimeTemp: String
    let eveningTemp: String
    let nighttimeTemp: String
    let minimumTemp: String
    let maximumTemp: String
    
    let morningFeelsLike: String
    let daytimeFeelsLike: String
    let eveningFeelsLike: String
    let nightimeFeelsLike: String
    
    let humidity: String
    let windspeed: String
    let windDegrees: String
    let description: String
    let chanceOfPrecipitation: String
    let uvIndex: String
    let icons: String
    let iconColors: [Color]
}

struct SavedLocationWeather {
    let name: String
    let date: String
    let temp: String
    let icon: String
    
    static let shared = SavedLocationWeather(name: "Konoha", date: "2005", temp: "100", icon: "sun.min")
}
