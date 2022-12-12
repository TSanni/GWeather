//
//  K.swift
//  GWeather
//
//  Created by Tomas Sanni on 9/6/22.
//

import Foundation
import SwiftUI

struct K {
    static let apiKey = Bundle.main.object(forInfoDictionaryKey: "apiKey")
    static let noDecimals = "%.0f"
    static let oneDecimal = "%.1f"
    static let twoDecimals = "%.2f"
    static let metric = "metric"
    static let imperial = "imperial"
    
    static let goodSearchBarBackground = Color(red: 56/255, green: 103/255, blue: 214/255, opacity: 1.0)

    struct WeatherConstants {
        static let dailyHours = 12
    }
    
    struct WeatherCondition {
        
        static let sunMaxFill = "sun.max.fill"
        static let moonStarsFill = "moon.stars.fill"
        static let cloudSunFill = "cloud.sun.fill"
        static let cloudMoonFill = "cloud.moon.fill"
        static let cloudFill = "cloud.fill"
        static let cloudRainFill = "cloud.rain.fill"
        static let cloudSunRainFill = "cloud.sun.rain.fill"
        static let cloudMoonRainFill = "cloud.moon.rain.fill"
        static let cloudBoltFill = "cloud.bolt.fill"
        static let snowflake = "snowflake"
        static let cloudFogFill = "cloud.fog.fill"
        static let sunMin = "sun.min"


        static let cloudDrizzleFill = "cloud.drizzle.fill"
        static let cloudSnowFill = "cloud.snow.fill"
        
        static let sunrise = "sunrise.fill"
        static let sunset = "sunset.fill"
    }
    struct Colors {
        
        
        
        
        static let offWhite = Color(hue: 0.104, saturation: 0.0, brightness: 0.897)
        static let moonColor = Color(hue: 0.556, saturation: 0.128, brightness: 0.864)
        static let silver = Color.red
        static let goodBlack = Color(red: 0.15, green: 0.15, blue: 0.15)
        static let darkBlue = Color(hue: 0.674, saturation: 0.986, brightness: 0.368)
        static let cloudyBlue = Color(red: 0.519, green: 0.644, blue: 0.785)

        static let thunderstormPurple = Color(red: 0.87, green: 0.24, blue: 0.595)
    }
    
    
    struct Gradients {
        static let purpleGradient = LinearGradient(colors: [.purple, .purple, .purple, .blue], startPoint: .top, endPoint: .bottom)
        
        static let blueGradient = LinearGradient(colors: [.blue, .blue, .blue, .purple], startPoint: .top, endPoint: .bottom)
    }
    
    struct SearchBarColors {
        static let blueColor = Color.blue
        static let purpleColor = Color.purple
    }
    
}
