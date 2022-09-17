//
//  WeatherTabViews.swift
//  GWeather
//
//  Created by Tomas Sanni on 8/30/22.
//

import SwiftUI

struct WeatherTabViews: View {
    @State private var selectedTab: TimeRange = .today//this changes when tabview page changes
    
    var body: some View {
        VStack(spacing: 0) {
            
            TimeRangeView(selectedTab: $selectedTab)
                .padding(.horizontal)
                .background(Color(red: 56/255, green: 103/255, blue: 214/255, opacity: 1.0))

            
            TabView(selection: $selectedTab) {
                TodayView().tabItem {
                    Label("Today", systemImage: "house")
                }.tag(TimeRange.today)
                
                TomorrowView().tabItem {
                    Label("Tomorrow", systemImage: "house")
                }.tag(TimeRange.tomorrow)
                
                DailyView().tabItem {
                    Label("10 Day", systemImage: "house")
                }.tag(TimeRange.tenDays)
                
                
            }.tabViewStyle(.page(indexDisplayMode: .never))
        }
        
    }
    
    
    
    
//    var barAndTimeRangeView: some View {
//        VStack {
//            SearchBarView()
//            //                .clipShape(RoundedRectangle(cornerRadius: 15))
//            TimeRangeView(selectedTab: $selectedTab).padding(.horizontal)
//        }
//        .padding(.horizontal)
//    }
}

struct WeatherTabViews_Previews: PreviewProvider {
    static var previews: some View {
        WeatherTabViews()
            .environmentObject(WeatherViewModel.shared)
    }
}
