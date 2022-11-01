//
//  TodayView.swift
//  GWeather
//
//  Created by Tomas Sanni on 8/29/22.
//

import SwiftUI

struct TodayView: View {
    
    @EnvironmentObject var weather: WeatherViewModel
    let currentWeather: CurrentWeatherModel
    let dailyWeather: DailyWeatherModel //will pass in first item in this array
    
    var body: some View {
        VStack(alignment: .leading) {

            Text(currentWeather.currentTime)
//            Text("August 45, 2:90")
                .font(.title2)
                .foregroundColor(Color.black)
                .padding(.bottom, 5)
                .shadow(color: Color.white ,radius: 1)
            
            Text("Day \(dailyWeather.maximumTemp)°↑ · Night \(dailyWeather.minimumTemp)°↓")
                .font(.title3)
                .shadow(color: Color.black, radius: 1)

            
            
            VStack {
                HStack {
                    Text("\(currentWeather.currentTemp)\(weather.unitLogo)")
                        .font(.system(size: 75))
                        .shadow(color: Color.black, radius: 1)

                    Spacer()
                    Image(systemName: currentWeather.icon)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(currentWeather.iconColor[0], currentWeather.iconColor[1], currentWeather.iconColor[2])
                        .frame(width: 100, height: 100)
                }
                .padding(.trailing)
                
                HStack {
                    Text("Feels like \(currentWeather.feelsLike)°")
                    Spacer()
                    Text(currentWeather.description.capitalized)
                    
                }
                .shadow(color: Color.black, radius: 1)
                .shadow(color: Color.black, radius: 1)
                .padding(.trailing)
            }
            


            
            Spacer()
            
            HourlyTempsView(hourly: weather.hourlyWeather)
            
            HStack {
                Image(systemName: "umbrella.fill")
                Text(dailyWeather.chanceOfPrecipitation + "% chance of precipitation today")
                Spacer()
            }
            .padding()
            .shadow(color: Color.black, radius: 10)
            
            

            
        }
        .padding()
        .background(weather.backgroundColor)

    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView(currentWeather: CurrentWeatherModel.shared, dailyWeather: DailyWeatherModel.shared)
            .preferredColorScheme(.dark)
            .environmentObject(WeatherViewModel.shared)
        
        TodayView(currentWeather: CurrentWeatherModel.shared, dailyWeather: DailyWeatherModel.shared)
            .previewDevice("iPhone SE (3rd generation)")
            .preferredColorScheme(.dark)
            .environmentObject(WeatherViewModel.shared)
        
        TodayView(currentWeather: CurrentWeatherModel.shared, dailyWeather: DailyWeatherModel.shared)
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
