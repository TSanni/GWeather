//
//  WeatherData.swift
//  GWeather
//
//  Created by Tomas Sanni on 9/7/22.
//

import Foundation


struct WeatherData: Codable {// outermost
    let lat: Double
    let lon: Double
    let timezone: String
    let timezone_offset: Int
    
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
}


struct Current: Codable {// data for the current weather
    let dt: Double
    let sunrise: Double
    let sunset: Double
    let temp: Double
    let feels_like: Double
    let pressure: Double
    let humidity: Int
    
    let weather: [Weather]
}

struct Hourly: Codable {
    let dt: Double
    let temp: Double
    let pop: Double
    let weather: [Weather]
}

struct Daily: Codable {// data for the daily weather
    let dt: Double
    let sunrise: Double
    let sunset: Double
    let temp: Temp
    let humidity: Double
    let wind_speed: Double
    let wind_deg: Double
    let weather: [Weather]
    let pop: Double
    let uvi: Double
}

struct Temp: Codable { // for Daily struct
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}




struct Weather: Codable { // this struct can be used for Current, Hourly, and Daily
    let id: Int
    let description: String
    let icon: String
}
