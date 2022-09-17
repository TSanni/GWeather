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
                        .background(Color(red: 56/255, green: 103/255, blue: 214/255, opacity: 1.0))
                    
                    WeatherTabViews()
                        .ignoresSafeArea()
                }
                //                .environmentObject(viewModel)
            } else {
                PlacesView(changeToPlacesView: $changeToPlacesView)
            }
        }
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
        
        
        
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //        ZStack {
        
        //            Color.orange.ignoresSafeArea()
        ContentView()
        //            .preferredColorScheme(.light)
            .previewDevice("iPhone 13 Pro Max")
        //        }
        
        ContentView()
        //            .preferredColorScheme(.dark)
            .previewDevice("iPod touch (7th generation)")
        
    }
}








