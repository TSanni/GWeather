//
//  SavedLocationsViews.swift
//  GWeather
//
//  Created by Tomas Sanni on 8/29/22.
//

import SwiftUI

struct SavedLocationsViews: View {
    var place: Place
    
    var body: some View {
        
        HStack {
//            Image(systemName: "circle.fill")
            Text("•")
                .foregroundColor(.black)
            Spacer()
            Text(place.wrappedName)
                .foregroundColor(.black)
            Spacer()
            Text("•")
                .foregroundColor(.black)
        }
        
        
//        VStack {
//            HStack {
//                VStack(alignment: .leading) {
//                    Text(place.wrappedName)
//                    Text(place.wrappedDate)
//                }
//                Spacer()
//
//                HStack {
//                    Text(place.wrappedTemp)
//                    Image(systemName: place.wrappedIcon)
//                }
//            }
//        }
    }
}

//struct SavedLocationsViews_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedLocationsViews()
//    }
//}
