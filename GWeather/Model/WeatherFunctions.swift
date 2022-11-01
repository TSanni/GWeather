//
//  WeatherFunctions.swift
//  GWeather
//
//  Created by Tomas Sanni on 9/14/22.
//

import Foundation
import SwiftUI

struct WeatherFunction {
    
    func getDate(timezoneOffset: Int) -> String {
        let date = Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timezoneOffset)
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMM dd, h:mm a"
        return dateFormatter.string(from: date)
    }
    
    func getAppropriateSearchBarColor(currentSunriseTime: Double, currentSunsetTime: Double, currentTime: Double) -> Color {
        if currentTime < currentSunsetTime && currentTime > currentSunriseTime  {
            return K.SearchBarColors.blueColor
        } else {
            return K.SearchBarColors.purpleColor
        }
    }
    
    //add sunrise time to parameter
    func getAppropriateBackgroundColor(currentSunriseTime: Double, currentSunsetTime: Double, currentTime: Double) -> LinearGradient {
        if currentTime < currentSunsetTime && currentTime > currentSunriseTime  {
            return K.Gradients.blueGradient
        } else {
            return K.Gradients.purpleGradient
        }
    }
//    
//    func getSearchBarBackgroundColor(gradientColor: LinearGradient) -> Color {
//        if gradientColor == K.Gradients.blueGradient {
//            return Color.teal
//        } else {
//            return Color.purple
//        }
//    }
    
//    func getAppropriateWeatherImage(weatherIcon: String) -> LinearGradient {
//
//
//
//
////        switch weatherIcon {
////        case K.WeatherCondition.sunMaxFill:
////            return K.Gradients.yellowGradient
////
////        default:
////            return LinearGradient(colors: [.black, .black], startPoint: .top, endPoint: .bottom)
////        }
//    }
    
    
    //Returns the daily date
    func getDailyDate(dateInDoubleFormat: [Double], timezoneOffset: Int) -> [String] {
        
        var eachDay: [String] = []
        
        for i in 0..<dateInDoubleFormat.count {
            
            let date = Date(timeIntervalSince1970: dateInDoubleFormat[i])
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(secondsFromGMT: timezoneOffset)
            
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "EEEE, MMM d"
            
            eachDay.append(dateFormatter.string(from: date))
            
        }
        
        return eachDay
        
    }
    
    //Takes an array of times (in double) and returns either the Sunrise
    //or Sunset times with the correct timezone
    func getSunriseSunsetTimes(timeInSeconds: [Double], timezoneOffset: Int, getShortHour: Bool) -> [String] {
        var riseOrSetTime: [String] = []
        var shortHourRiseOrSet: [String] = []
        
        for i in 0..<timeInSeconds.count {
            let date = Date(timeIntervalSince1970: timeInSeconds[i])
            
            let dateFormatter = DateFormatter()
            let dateFormatter2 = DateFormatter()
            
            dateFormatter.timeZone = TimeZone(secondsFromGMT: timezoneOffset)
            dateFormatter2.timeZone = TimeZone(secondsFromGMT: timezoneOffset)
            
            dateFormatter.locale = NSLocale.current
            dateFormatter2.locale = NSLocale.current
            
            dateFormatter.dateFormat = "h:mm a"
            dateFormatter2.dateFormat = "h a"
            
            let readableTime = dateFormatter.string(from: date)
            let readableTime2 = dateFormatter2.string(from: date)
            
            riseOrSetTime.append(readableTime)
            shortHourRiseOrSet.append(readableTime2)
        }
        
        if getShortHour {
            return shortHourRiseOrSet // will be 12 PM format using dateFormatter2
        } else {
            return riseOrSetTime // will be 12:00 PM format using dateFormatter
        }
        
    }
    
    
    func getReadableHour(hourInSecond: [Double], timezoneOffset: Int) -> [String] {
        var readableHour: [String] = []
        
        for i in 0..<hourInSecond.count {
            let date = Date(timeIntervalSince1970: hourInSecond[i])
            let dateFormatter2 = DateFormatter()
            dateFormatter2.timeZone = TimeZone(secondsFromGMT: timezoneOffset)
            
            dateFormatter2.locale = NSLocale.current
            dateFormatter2.dateFormat = "h a"
            
            let hour = dateFormatter2.string(from: date)
            readableHour.append(hour)
        }
        
        return readableHour
        
    }
    
    
    func getSFSymbolWeatherIcon(apiIcon: String) -> String {
        switch apiIcon {
        case "01d":
            return K.WeatherCondition.sunMaxFill
        case "01n":
            return K.WeatherCondition.moonStarsFill
        case "02d":
            return K.WeatherCondition.cloudSunFill
        case "02n":
            return K.WeatherCondition.cloudMoonFill
        case "03d":
            return K.WeatherCondition.cloudFill
        case "03n":
            return K.WeatherCondition.cloudFill
        case "04d":
            return K.WeatherCondition.cloudFill
        case "04n":
            return K.WeatherCondition.cloudFill
        case "09d":
            return K.WeatherCondition.cloudRainFill
        case "09n":
            return K.WeatherCondition.cloudRainFill
        case "10d":
            return K.WeatherCondition.cloudSunRainFill
        case "10n":
            return K.WeatherCondition.cloudMoonRainFill
        case "11d":
            return K.WeatherCondition.cloudBoltFill
        case "11n":
            return K.WeatherCondition.cloudBoltFill
        case "13d":
            return K.WeatherCondition.snowflake
        case "13n":
            return K.WeatherCondition.snowflake
        case "50d":
            return K.WeatherCondition.cloudFogFill
        case "50n":
            return K.WeatherCondition.cloudFogFill
            
            
            
        default:
            print("Error: Check 'WeatherIcon' File")
            return K.WeatherCondition.sunMin
        }
    }
    
    func getSFColorForIcon(sfIcon: String) -> [Color] {
//        let offWhite = Color(hue: 0.104, saturation: 0.0, brightness: 0.897)
//        let moonColor = Color(hue: 0.556, saturation: 0.128, brightness: 0.864)
        
        
        switch sfIcon {
        case K.WeatherCondition.sunMaxFill:
            return [.yellow, .yellow, .yellow]
        case K.WeatherCondition.moonStarsFill:
            return [K.Colors.moonColor, K.Colors.offWhite, .clear]
        case K.WeatherCondition.cloudSunFill:
            return [K.Colors.offWhite, .yellow, .clear]
        case K.WeatherCondition.cloudMoonFill:
            return [K.Colors.offWhite, K.Colors.moonColor, .clear]
        case K.WeatherCondition.cloudFill:
            return [K.Colors.offWhite, K.Colors.offWhite, K.Colors.offWhite]
        case K.WeatherCondition.cloudRainFill:
            return [K.Colors.offWhite, .cyan, .clear]
        case K.WeatherCondition.cloudSunRainFill:
            return [K.Colors.offWhite, .yellow, .cyan]
        case K.WeatherCondition.cloudMoonRainFill:
            return [K.Colors.offWhite, K.Colors.moonColor, .cyan]
        case K.WeatherCondition.cloudBoltFill:
            return [K.Colors.offWhite, .yellow, .clear]
        case K.WeatherCondition.snowflake:
            return [K.Colors.offWhite, .clear, .clear]
        case K.WeatherCondition.cloudFogFill:
            return [K.Colors.offWhite, .gray, .clear]
            
        default:
            print("Error getting color")
            return [.pink, .pink]
        }
    }
    
}
