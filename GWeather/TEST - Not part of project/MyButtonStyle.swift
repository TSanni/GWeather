//
//  MyButtonStyle.swift
//  GWeather
//
//  Created by Tomas Sanni on 8/29/22.
//

import SwiftUI

struct MyButtonStyle: ButtonStyle {

  func makeBody(configuration: Self.Configuration) -> some View {
      VStack {
          configuration.label
//              .padding()
              .foregroundColor(.black)
              .background(configuration.isPressed ? Color.gray : Color.white)
              .cornerRadius(8.0)
          
//          if configuration.isPressed {
//              RoundedRectangle(cornerRadius: 10)
//                  .frame(height: 7)
//          }
          
          
      }
  }
    

}
