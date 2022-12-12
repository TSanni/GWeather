//
//  Enums.swift
//  GWeather
//
//  Created by Tomas Sanni on 12/5/22.
//

import Foundation
import SwiftUI

enum ChangeBackground {
    
    case daytimeClear
    case nighttimeClear
    case daytimeRain
    case nighttimeRain
    case cloudAndRain
    case thunderstorm
    case daytimeSnow
    case nighttimeSnow
    case daytimeFog
    case nighttimeFog
    
    
    
    var getSearchBarColor: Color {
        switch self {
        case .daytimeClear:
            return Color.ClearOrCloudyDay.sunny1
        case .nighttimeClear:
            return Color.ClearOrCloudyNight.night2
        case .daytimeRain:
            return Color.DayRain.dayRain
        case .nighttimeRain:
            return Color.NightRain.nightRain1
        case .cloudAndRain:
            return Color.DayRain.dayRain
        case .thunderstorm:
            return Color.Thunderstorm.thunder1
        case .daytimeSnow:
            return Color.DaySnow.daySnow1
        case .nighttimeSnow:
            return Color.NightSnow.nightSnow1
        case .daytimeFog:
            return Color.DayRain.dayRain
        case .nighttimeFog:
            return Color.NightRain.nightRain4
        }
    }
    
    
    var getBackgroundColor: Color {
        switch self {
        case .daytimeClear:
            return Color.ClearOrCloudyDay.sunny1
        case .nighttimeClear:
            return Color.ClearOrCloudyNight.night1
        case .daytimeRain:
            return Color.DayRain.dayRain
        case .nighttimeRain:
            return Color.NightRain.nightRain4
        case .cloudAndRain:
            return Color.DayRain.dayRain
        case .thunderstorm:
            return Color.Thunderstorm.thunder2
        case .daytimeSnow:
            return Color.DaySnow.daySnow2
        case .nighttimeSnow:
            return Color.NightSnow.nightSnow2
        case .daytimeFog:
            return Color.DayRain.dayRain
        case .nighttimeFog:
            return Color.NightRain.nightRain2
        }
    }
    
    
//    var getPicture: LinearGradient {
//        switch self {
//        case .daytimeClear:
//            return LinearGradient(colors: [.yellow, .blue], startPoint: .top, endPoint: .bottom)
//
//        case .nighttimeClear:
//            return LinearGradient(colors: [K.Colors.darkBlue, .indigo, K.Colors.darkBlue], startPoint: .top, endPoint: .bottom)
//
//        case .daytimeRain:
//            return LinearGradient(colors: [.gray, .blue], startPoint: .top, endPoint: .bottom)
//
//        case .nighttimeRain:
//            return LinearGradient(colors: [.gray, K.Colors.darkBlue], startPoint: .top, endPoint: .bottom)
//
//        case .cloudAndRain:
//            return LinearGradient(colors: [.gray, .gray, K.Colors.offWhite, .gray, .gray], startPoint: .top, endPoint: .bottom)
//
//        case .thunderstorm:
//            return LinearGradient(colors: [K.Colors.thunderstormPurple, K.Colors.thunderstormPurple, K.Colors.thunderstormPurple, .gray], startPoint: .top, endPoint: .bottom)
//
//        case .daytimeSnow:
//            return LinearGradient(colors: [K.Colors.cloudyBlue, K.Colors.cloudyBlue, K.Colors.cloudyBlue, .white], startPoint: .top, endPoint: .bottom)
//
//        case .nighttimeSnow:
//            return LinearGradient(colors: [K.Colors.darkBlue, K.Colors.darkBlue, K.Colors.darkBlue, .indigo], startPoint: .top, endPoint: .bottom)
//
//        case .daytimeFog:
//            return LinearGradient(colors: [K.Colors.cloudyBlue, K.Colors.cloudyBlue, .gray], startPoint: .top, endPoint: .bottom)
//
//        case .nighttimeFog:
//            return LinearGradient(colors: [.gray, K.Colors.cloudyBlue, K.Colors.darkBlue, K.Colors.darkBlue], startPoint: .top, endPoint: .bottom)
//
//        }
//    }
    
    
}
