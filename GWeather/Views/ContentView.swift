//
//  ContentView.swift
//  GWeather
//
//  Created by Tomas Sanni on 8/29/22.
//

import SwiftUI
import Charts

struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel()
    @Environment(\.scenePhase) var scenePhase
    @State private var savedDate = Date()
    @State private var presentAlert = false
    @State private var unknownPlace = false
    
    //two binding variables to this @State in SearchBarView
    //and PlacesView
    @State private var changeToPlacesView = false
    var body: some View {
        
        VStack(spacing: 0) {
            if !changeToPlacesView {
                VStack(spacing: 0) {
                    
                    SearchBarView(changeToPlacesView: $changeToPlacesView)
                        .foregroundColor(.black)
                        .padding([.horizontal, .bottom])
                        .background(viewModel.searchBarColor)
                    
                    WeatherTabViews()
                        .ignoresSafeArea()
                }
            } else {
                PlacesView(changeToPlacesView: $changeToPlacesView)
            }
        }
        .preferredColorScheme(changeToPlacesView ? .light : .dark)
        .environmentObject(viewModel)
        .onChange(of: scenePhase) { newValue in
            //use this modifier to periodically update the information
            if newValue == .active {
                if -savedDate.timeIntervalSinceNow > 60 * 10 {
                    print("10 minutes have passed")
                    viewModel.manager.startUpdatingLocation()
                    savedDate = Date()
                } else {
                    print("10 minutes have NOT passed")
                }
            }
        }
        .alert("Weather Update Failed", isPresented: $presentAlert) {
            Button("Dismiss") {
                
            }
        } message: {
            Text("Failed to get weather for your current location. Try going to the settings app and change location preference to 'While Using the App'")
        }
        .alert("Unknown Location", isPresented: $unknownPlace) {
            
        } message: {
            Text("The submitted location is not recognized. Please enter a city.")
        }
        .onChange(of: viewModel.errorAlertForMainScreen) { newValue in
            print(newValue)
            presentAlert = true

        }
        .onChange(of: viewModel.errorAlertForSearch) { newValue in
            unknownPlace = true
        }
        

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ZStack {
        
//        Color.orange.ignoresSafeArea()
        ContentView()
//            .preferredColorScheme(.light)
            .previewDevice("iPhone 13 Pro Max")
//        }
        
        ContentView()
//            .preferredColorScheme(.dark)
            .previewDevice("iPod touch (7th generation)")
        
    }
}








