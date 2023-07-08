//
//  HourlyBarGraphView.swift
//  GWeather
//
//  Created by Tomas Sanni on 12/4/22.
//

import SwiftUI
import Charts



struct TestGraphStruct: Identifiable {
    var id = UUID()
    let xAxis: String
    let yAxis: Double
    
    
    
}


//MARK: - Main
struct HourlyBarGraphView: View {
    
    
    let mockTestData: [TestGraphStruct] = [TestGraphStruct(xAxis: "A", yAxis: 10),
                                                  TestGraphStruct(xAxis: "B", yAxis: 20),
                                                  TestGraphStruct(xAxis: "C", yAxis: 30),
                                                  TestGraphStruct(xAxis: "D", yAxis: 20),
                                                  TestGraphStruct(xAxis: "E", yAxis: 10),
                                                  
                                                  ]
    
    var screenWidth = UIScreen.main.bounds.width
    var hourly: [HourlyWeatherModel]
    
    var body: some View {
        ScrollView(.horizontal) {
            
            
            Chart {
                
                //MARK: - Area Graph
                ForEach(hourly) { hour in
                    AreaMark(x: .value("Name", hour.time), y: .value("Number", Double(hour.temp) ?? 0.0))
                        .foregroundStyle(.blue.opacity(0.5))

                }
                
                
                //MARK: - Bar Graph
                ForEach(hourly) { hour in
                    BarMark(x: .value("Name", hour.time), y: .value("Number", Double(hour.temp) ?? 0.0))
                        .annotation(position: .top , alignment: .center, spacing:0) {
                            ExtractedView(hour: hour)
                        }
                        .annotation(position: .overlay, alignment: .center, spacing: 0) {
                            ExtractedView2(hour: hour)
                        }
                        .foregroundStyle(.red.opacity(0.0))
                }
                
        
//                ForEach(mockTestData) { hour in
//                    BarMark(x: .value("Name", hour.xAxis), y: .value("Number", hour.yAxis))
//                        .annotation(position: .top , alignment: .center, spacing:0) {
//                            Image(systemName: "cloud.rain.fill")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 25, height: 25)
//                                .foregroundStyle(.green,
//                                                 .green,
//                                                 .green)
//                        }
//
//                        .foregroundStyle(.red.opacity(0.7))
//                }
                
            }
            
            .frame(width: screenWidth * 2)
            .frame(height: 200)
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            
        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.black.opacity(0.2))
        }
    }
}

//MARK: - Preview
struct HourlyBarGraphView_Previews: PreviewProvider {
    static var previews: some View {
        
        
        let testDataArray: [HourlyWeatherModel] = [
            HourlyWeatherModel(temp: "100", time: "7Am", pop: "0", icon: "", iconColor: []),
            HourlyWeatherModel(temp: "101", time: "8Am", pop: "0", icon: "", iconColor: []),
            HourlyWeatherModel(temp: "99", time: "9Am", pop: "0", icon: "", iconColor: []),
            HourlyWeatherModel(temp: "100", time: "10Am", pop: "0", icon: "", iconColor: []),
            HourlyWeatherModel(temp: "100", time: "11Am", pop: "0", icon: "", iconColor: []),
            HourlyWeatherModel(temp: "98", time: "12Am", pop: "0", icon: "", iconColor: []),
            HourlyWeatherModel(temp: "97", time: "2Am", pop: "0", icon: "", iconColor: []),
            HourlyWeatherModel(temp: "101", time: "3Am", pop: "0", icon: "", iconColor: []),
            HourlyWeatherModel(temp: "100", time: "4Am", pop: "0", icon: "", iconColor: []),
            HourlyWeatherModel(temp: "100", time: "5Am", pop: "0", icon: "", iconColor: []),
            HourlyWeatherModel(temp: "99", time: "6Am", pop: "0", icon: "", iconColor: []),
            
            
        ]
        
        
        HourlyBarGraphView(hourly: testDataArray)
    }
}


struct ExtractedView: View {
    var hour: HourlyWeatherModel

    var body: some View {
        Text(hour.temp + "°")
            .fontWeight(.thin)
    }
}





struct ExtractedView2: View {
    
    var hour: HourlyWeatherModel
    
    var body: some View {
        VStack {
            Spacer()
            
            if hour.pop == "0%" {
                Text(" ")
                    .fontWeight(.light)
            } else {
                Text(hour.pop)
                    .foregroundColor(K.Colors.precipitationBlue)
                    .fontWeight(.light)
            }
            
            Image(systemName: hour.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundStyle(hour.iconColor[0],
                                 hour.iconColor[1],
                                 hour.iconColor[2])
            Text(hour.time)
                .fontWeight(.light)
            
        }
    }
}


