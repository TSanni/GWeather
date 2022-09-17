//
//  PlacesView.swift
//  GWeather
//
//  Created by Tomas Sanni on 8/29/22.
//

import SwiftUI

struct PlacesView: View {
    @State private var searchText = ""
//    @EnvironmentObject var viewModel: WeatherViewModel
    @State var degreeRotation: Double = 0
    @Binding var changeToPlacesView: Bool
    @EnvironmentObject var weather: WeatherViewModel
    
    var body: some View {
        VStack {
            HStack {
                arrowButton
                textFieldSearch
            }.padding(.top)
            
            Divider().padding()
            
            currentLocationInfo
                .padding(.bottom)
            
            HStack {
                Text("Saved locations")
                Spacer()
                Button("MANAGE") {
                    
                }
                .foregroundColor(.black)
            }
            
            Divider()
            
            ForEach(0..<2, id: \.self) { view in
                SavedLocationsViews().padding(.vertical)
                Divider()
            }
            Spacer()
        }
        .padding(.horizontal)
    }
    
    
    
    
    
    
    
    var arrowButton: some View {
        Button {
            withAnimation {
                degreeRotation -= 360
//                viewModel.changeToPlacesView = false
                changeToPlacesView = false
                
            }
        } label: {
            Image(systemName: "arrow.left")
                .rotationEffect(Angle(degrees: degreeRotation))
                .animation(.spring(), value: degreeRotation)
                .padding(.horizontal)
        }
    }
    
    var currentLocationInfo: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(weather.userLocation)
                HStack {
                    Image(systemName: "location.fill")
                        .foregroundColor(.blue)
                    Text("Your location")
                }
            }
            Spacer()
            HStack {
                Text(weather.currentWeather.currentTemp + "℉")
                Image(systemName: weather.currentWeather.icon)
                    .foregroundStyle(weather.currentWeather.iconColor[0],
                                     weather.currentWeather.iconColor[1],
                                     weather.currentWeather.iconColor[2]
                    )
            }
        }
    }
    
    var textFieldSearch: some View {
        TextField("Search Places", text: $searchText)

    }
    
    
}

struct PlacesView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesView(changeToPlacesView: .constant(false)).environmentObject(WeatherViewModel.shared)
    }
}
