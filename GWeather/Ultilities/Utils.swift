//
//  Utils.swift
//  GWeather
//
//  Created by Tomas Sanni on 10/9/22.
//

import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}




extension Color {
    
    struct ClearOrCloudyDay {
        
        static var sunny1: Color {
            return Color("Sunny1")
        }
        static var sunny2: Color {
            return Color("Sunny2")
        }
        static var sunny3: Color {
            return Color("Sunny3")
        }
        static var sunny4: Color {
            return Color("Sunny4")
        }
    }
    
    
    struct ClearOrCloudyNight {
        
        static var night1: Color {
            return Color("Night1")
        }
        static var night2: Color {
            return Color("Night2")
        }
        static var night3: Color {
            return Color("Night3")
        }
        static var night4: Color {
            return Color("Night4")
        }
    }
    
    
    struct DayRain {
        
        static var dayRain: Color {
            return Color("dayRain")
        }
    }
    
    
    struct DaySnow {
        
        static var daySnow1: Color {
            return Color("DaySnow1")
        }
        static var daySnow2: Color {
            return Color("DaySnow2")
        }

    }
    
    struct NightSnow {
        
        static var nightSnow1: Color {
            return Color("NightSnow1")
        }
        static var nightSnow2: Color {
            return Color("NightSnow2")
        }

    }
    
    
    
    struct NightRain {
        
        static var nightRain1: Color {
            return Color("NightRain1")
        }
        static var nightRain2: Color {
            return Color("NightRain2")
        }
        static var nightRain3: Color {
            return Color("NightRain3")
        }
        static var nightRain4: Color {
            return Color("NightRain4")
        }
    }
    
    
    struct Thunderstorm {
        
        static var thunder1: Color {
            return Color("thunder1")
        }
        static var thunder2: Color {
            return Color("thunder2")
        }
        static var thunder3: Color {
            return Color("thunder3")
        }
        static var thunder4: Color {
            return Color("thunder4")
        }
    }
    
}
