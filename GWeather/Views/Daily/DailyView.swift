//
//  DailyView.swift
//  GWeather
//
//  Created by Tomas Sanni on 9/1/22.
//

import SwiftUI

struct DailyView: View {
    @EnvironmentObject var weather: WeatherViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                DailyViewCell(daily: weather.dailyWeather[0], dateIsToday: true).padding()
                
                Divider()
                
                ForEach(1..<weather.dailyWeather.count, id: \.self) { day in
                    DailyViewCell(daily: weather.dailyWeather[day], dateIsToday: false).padding()
                    Divider()
                }
            }
        }
        .background(.white)
        .foregroundColor(.black)
    }
}

struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        DailyView().environmentObject(WeatherViewModel.shared)
    }
}
