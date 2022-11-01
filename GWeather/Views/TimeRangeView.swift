//
//  TimeRangeView.swift
//  GWeather
//
//  Created by Tomas Sanni on 8/29/22.
//

import SwiftUI

enum TimeRange: String, CaseIterable {
    case today = "Today"
    case tomorrow = "Tomorrow"
    case tenDays = "8 Days"
}



struct TimeRangeView: View {
//    @EnvironmentObject var viewModel: WeatherViewModel
    @State private var selectedRange: TimeRange = .today
    @Binding var selectedTab: TimeRange // to get underline when swiping screen
    @Namespace private var animation
    @EnvironmentObject var weather: WeatherViewModel
    @State var changeSearchBarColor: Color = .brown
    
    var body: some View {
        HStack {
            ForEach(TimeRange.allCases, id: \.self) { range in
                Button {
                    // change Weather range
                    withAnimation {
//                        selectedRange = range
                        selectedTab = range
//                        switch selectedTab {
//                        case .today:
//                            weather.searchBarColor = .red
//                        case .tomorrow:
//                            weather.searchBarColor = .yellow
//                        case .tenDays:
//                            weather.searchBarColor = .green
//                        }
                    }
                } label: {
                    VStack {
                        // Today, Tomorrow, 10 Days
                        Text(range.rawValue)
                            .foregroundColor(Color.black)
                        
                        // Underline correct button
                        if selectedTab == range { //only using selectedTab works here for some reason
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .frame(width: 70, height: 5)
                                .matchedGeometryEffect(id: "selected", in: animation)
                        } 
                    }
                }
                if range != .tenDays { Spacer() }
            }
        }

    }
}

struct TimeRangeView_Previews: PreviewProvider {
    static var previews: some View {
        TimeRangeView(selectedTab: .constant(.today))
            .previewDevice("iPhone 13 Pro Max")
            .background(.blue)
            .environmentObject(WeatherViewModel.shared)
    }
}
