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
            HStack {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .rotationEffect(Angle(degrees: degreeRotation))
                    .animation(.default, value: degreeRotation)
                
                Text(viewModel.userLocation)
                
                Spacer()
                
            }
            .padding()
//            .background(.gray)
            .onTapGesture {
                withAnimation {
                    degreeRotation += 360
//                    viewModel.changeToPlacesView = true
                    changeToPlacesView = true
                    
                }
            }
            
            Button {
                settingsScreen = true
            } label: {
                
                ZStack {
                    Color.gray
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    
                    Image(systemName: "gear")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }.padding(.trailing)
                
//                Circle()
//                    .frame(width: 40, height: 40)
//                    .overlay {
//                        Text("T")
//                            .foregroundColor(.red)
//                    }
//                    .padding(.trailing)
            }

            

        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .sheet(isPresented: $settingsScreen) {
            SettingsScreen()
        }

    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(changeToPlacesView: .constant(false)).background(.orange)
            .environmentObject(WeatherViewModel.shared)
            
    }
}
