//
//  SavedLocationsViews.swift
//  GWeather
//
//  Created by Tomas Sanni on 8/29/22.
//

import SwiftUI

struct SavedLocationsViews: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Austin, Tx")
                    Text("August, 29, 10:05 AM")
                }
                Spacer()
                
                HStack {
                    Text("81℉")
                    Image(systemName: "cloud.fill")
                }
            }
        }
    }
}

struct SavedLocationsViews_Previews: PreviewProvider {
    static var previews: some View {
        SavedLocationsViews()
    }
}
