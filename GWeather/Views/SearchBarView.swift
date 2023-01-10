//
//  SearchBarView.swift
//  GWeather
//
//  Created by Tomas Sanni on 8/29/22.
//

import SwiftUI

struct SearchBarView: View {
//    @EnvironmentObject var viewModel: WeatherViewModel
    
    @State private var searchText: String = ""
    @State private var degreeRotation: Double = 0
    @State private var settingsScreen = false
    @Binding var changeToPlacesView: Bool
    @EnvironmentObject var viewModel: WeatherViewModel
    
    var body: some View {
        ZStack(alignment: .trailing) {
            
            
            //Button with icon and location name
            Button {
                withAnimation {
                    degreeRotation += 360
                }
                
                //damping = bounciness? | blendDuration = elements within bouciness?
                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.55, blendDuration: 1)) {
                    changeToPlacesView = true

                }
            } label: {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.black)
                        .rotationEffect(Angle(degrees: degreeRotation))
//                        .animation(.default, value: degreeRotation)
                    
                    Text(viewModel.userLocation)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                }
                .padding()
            }

            

            //Button to show settings
            SettingsScreen()
            
            
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(red: 0.15, green: 0.15, blue: 0.15)
            SearchBarView(changeToPlacesView: .constant(false)).background(.orange)
                .environmentObject(WeatherViewModel.shared)
        }
            
    }
}
