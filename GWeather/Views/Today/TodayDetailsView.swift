//
//  TodayDetailsView.swift
//  GWeather
//
//  Created by Tomas Sanni on 8/31/22.
//

//NOT USED IN PROJECT

import SwiftUI

struct TodayDetailsView: View {
    var body: some View {
        ScrollView {
            CurrentDetailsView()
            Divider()
            VStack(alignment: .leading) {
                Text("Sunrise & Sunset")
                    .padding(.vertical)
                
                HStack {
                    VStack(spacing: 10) {
                        Text("Sunrise")
                        Text("12:00 AM")
                    }
                     Spacer()
                    
                    VStack(spacing: 10) {
                        Text("Sunset")
                        Text("12:00 AM")
                    }
                }
                
                
            }
        }
    }
}

struct TodayDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TodayDetailsView()
    }
}

struct CurrentDetailsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Current details")
                .padding(.bottom)
            VStack(spacing: 10) {
                
                HStack {
                    Text("Humidity")
                    Spacer()
                    Text("100%")
                    Spacer()
                }
                
                HStack {
                    Text("Dew Point")
                    Spacer()
                    Text("100%")
                    Spacer()
                }
                
                HStack {
                    Text("Pressure")
                    Spacer()
                    Text("100 inHg")
                    Spacer()
                }
                
                HStack {
                    Text("UV index")
                    Spacer()
                    Text("Moderate, 100")
                    Spacer()
                }
                
                HStack {
                    Text("Visibility")
                    Spacer()
                    Text("100 mi")
                    Spacer()
                }
                
                
            }
        }
    }
}
