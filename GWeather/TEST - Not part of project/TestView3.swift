//
//  TestView3.swift
//  GWeather
//
//  Created by Tomas Sanni on 10/22/22.
//

import SwiftUI

struct TestView3: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Hello, World!")
            Spacer()
        }
        .background(RadialGradient(colors: [.purple, .blue], center: .center, startRadius: 10, endRadius: 90))
    }
}

struct TestView3_Previews: PreviewProvider {
    static var previews: some View {
        TestView3()
    }
}
