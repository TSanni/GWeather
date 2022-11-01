//
//  TestView.swift
//  GWeather
//
//  Created by Tomas Sanni on 9/3/22.
//

import SwiftUI
import Charts

struct TestView: View {
    let screenwidth = UIScreen.main.bounds.width
    @EnvironmentObject var viewModel: WeatherViewModel
    
    struct TestData {
        let time: String
        let temp: Double
    }

    let testDataArray: [TestData] = [TestData(time: "1", temp: 74),
                                     TestData(time: "2", temp: 76),
                                     TestData(time: "3", temp: 79),
                                     TestData(time: "4", temp: 82),
                                     TestData(time: "5", temp: 84),
                                     TestData(time: "6", temp: 87),
                                     TestData(time: "7", temp: 88),
                                     TestData(time: "8", temp: 90),
                                     TestData(time: "9", temp: 70),
                                     TestData(time: "10", temp: 70)


    ]
    
    var body: some View {
        VStack {
            
            if #available(iOS 16.0, *) {
                Chart(testDataArray, id: \.time) { i in
                    LineMark(x: .value("Hi", i.time), y: .value("There", i.temp))
//                        .symbol(.diamond)
                        .symbol(.plus)
                        .foregroundStyle(.blue)
//                        .opacity(0.3)



                }
                .chartXAxis {
                    AxisMarks(position: .top)
                }
                .chartYAxis(content: {
                    AxisMarks(position: .trailing, values: .stride(by: 20))
                    
                })
                .chartYScale(domain: 0...100, type: .linear)

//                .chartYAxis(.hidden)
//                .chartXAxis(.hidden)
                .frame(width: screenwidth, height: 300)
            } else {
                // Fallback on earlier versions
            }

        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
            .environmentObject(WeatherViewModel.shared)
    }
}
