//
//  SwiftUIView.swift
//  GWeather
//
//  Created by Tomas Sanni on 8/29/22.
//

import SwiftUI

struct SwiftUIView: Shape {
    var yValues: [Double] = [0.8, 0.9, 0.8, 0.9, 0.8]
    var xValues: [Double] = [100, 200, 300, 400, 450]
    
    
    func path(in rect: CGRect) -> Path {
        let xIncrement = (rect.width / (CGFloat(yValues.count) - 1))
        var path = Path()
        
        path.move(to: CGPoint(x: 0.0, y: (1.0 - yValues[0]) * Double(rect.height)))

        for i in 1..<yValues.count {
            let pt = CGPoint(x:( Double(i) * Double(xIncrement)), y: ((1.0 - yValues[i]) * Double(rect.height)))

            path.addLine(to: pt)

        }
        
        
        
        
//        path.move(to: CGPoint(x: 0, y: 0))
//
//        for value in 0..<yValues.count {
//            path.addLine(to: CGPoint(x: xValues[value], y: yValues[value]))
//        }



        print(rect.width)
        print(rect.height)
        return path

    }
    
    
    
    
    

}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
//        let yValuesTest: [Double] = [0.2, 0.4, 0.3, 0.8, 0.5]

        SwiftUIView()
            .stroke(Color.red, lineWidth: 5)
            .environmentObject(WeatherViewModel.shared)
    }
}
