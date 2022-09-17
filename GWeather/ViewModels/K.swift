//
//  K.swift
//  GWeather
//
//  Created by Tomas Sanni on 9/6/22.
//

import Foundation
struct K {
    static let apiKey = Bundle.main.object(forInfoDictionaryKey: "apiKey")
    
    
    struct WeatherConstants {
        static let dailyHours = 24
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
    
}
