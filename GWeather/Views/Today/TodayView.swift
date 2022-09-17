//
//  TodayView.swift
//  GWeather
//
//  Created by Tomas Sanni on 8/29/22.
//

import SwiftUI

struct TodayView: View {
    let reallyDarkBlue = Color(hue: 0.674, saturation: 0.986, brightness: 0.368)
    let blueGradient = LinearGradient(colors: [.blue, Color(hue: 0.674, saturation: 0.986, brightness: 0.368)], startPoint: .top, endPoint: .bottom)
    let test = UIDevice.current.userInterfaceIdiom
    
    @EnvironmentObject var weather: WeatherViewModel
    
    var body: some View {
        VStack(alignment: .leading) {

            Text(weather.currentWeather.currentTime)
//            Text("August 45, 2:90")
                .font(.title2)
                .foregroundColor(Color.black)
                .padding(.bottom, 5)
                .shadow(color: Color.white ,radius: 1)
            
            Text("Day \(weather.dailyWeather[0].maximumTemp)°↑ · Night \(weather.dailyWeather[0].minimumTemp)°↓")
                .font(.title3)
                .shadow(color: Color.black, radius: 1)

            
            
            HStack {
                Text("\(weather.currentWeather.currentTemp)\(weather.unitLogo)")
                    .font(.system(size: 75))
                    .shadow(color: Color.black, radius: 1)

                Spacer()
                Image(systemName: weather.currentWeather.icon)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(weather.currentWeather.iconColor[0], weather.currentWeather.iconColor[1], weather.currentWeather.iconColor[2])
                    .frame(width: 100, height: 100)
            }
            .padding(.trailing)
            
            HStack {
                Text("Feels like \(weather.currentWeather.feelsLike)°")
                Spacer()
                Text(weather.currentWeather.description.capitalized)
                
            }
            .shadow(color: Color.black, radius: 1)
            .shadow(color: Color.black, radius: 1)
            .padding(.trailing)

            
            Spacer()
            
            HourlyTempsView()
            
            HStack {
                Image(systemName: "umbrella.fill")
                Text(weather.dailyWeather[0].chanceOfPrecipitation + "% chance of precipitation today")
                Spacer()
            }
            .padding()
            .shadow(color: Color.black, radius: 10)
            
            

            
        }
        .padding()
        .background(blueGradient)

    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
            .preferredColorScheme(.dark)
            .environmentObject(WeatherViewModel.shared)
        
        TodayView()
            .previewDevice("iPhone SE (3rd generation)")
            .preferredColorScheme(.dark)
            .environmentObject(WeatherViewModel.shared)
        
        TodayView()
            .previewDevice("iPod touch (7th generation)")
            .preferredColorScheme(.light)
            .environmentObject(WeatherViewModel.shared)
        
    }
}
























//        .gesture(gesture.onChanged({ value in
//            if value.translation.height < 200 {
//                alpha = 0
//
//                print("value changed")
//                withAnimation {
//                    changeToDetails = true
//
//                }
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                    alpha = 1
//                }
//
//            }
//
//            if value.translation.height > 200 {
//                withAnimation {
//                    changeToDetails = false
//                }
//            }
//        }))






//@State var alpha: Double = 0
//@State private var changeToDetails = false
//let gesture = DragGesture(minimumDistance: 200, coordinateSpace: .global)


//if changeToDetails {
//    TodayDetailsView()
//        .opacity(alpha)
//}
