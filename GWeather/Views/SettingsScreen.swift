//
//  SettingsScreen.swift
//  GWeather
//
//  Created by Tomas Sanni on 9/15/22.
//

import SwiftUI

struct SettingsScreen: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("highlight") var highlightedID = 1
    @State private var showSheet = false
    
    var body: some View {
        
        
        Button {
            showSheet.toggle()
        } label: {
            ZStack {
                
                K.Colors.goodBlack
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                Image(systemName: "gear")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
            }
            .padding(.trailing)
        }
        .sheet(isPresented: $showSheet) {
            SettingsView()
                .presentationDetents([.fraction(0.3), .medium])
        }
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
            .environmentObject(WeatherViewModel.shared)
    }
}


