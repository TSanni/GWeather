//
//  TestView2.swift
//  GWeather
//
//  Created by Tomas Sanni on 9/17/22.
//

import SwiftUI
import Charts

//// A modifier that animates a font through various sizes.
//struct AnimatableCustomFontModifier: ViewModifier, Animatable {
//    var name: String
//    var size: Double
//
//    var animatableData: Double {
//        get { size }
//        set { size = newValue }
//    }
//
//    func body(content: Content) -> some View {
//        content
//            .font(.custom(name, size: size))
//    }
//}

// To make that easier to use, I recommend wrapping
// it in a `View` extension, like this:
//extension View {
//    func animatableFont(name: String, size: Double) -> some View {
//        self.modifier(AnimatableCustomFontModifier(name: name, size: size))
//    }
//}

// An example View trying it out
struct TestView2: View {
    @State private var fontSize = 32.0

    var body: some View {
        Menu {
            Button("Print") {
                print("Printing...")
            }
        } label: {
//            Image(systemName: "menucard.fill")
            Label("hj", systemImage: "menucard.fill")
        }

//            .animatableFont(name: "Georgia", size: fontSize)
//            .onTapGesture {
//                withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1).repeatForever()) {
//                    fontSize = 72
//                }
//            }
    }
}


struct TestView2_Previews: PreviewProvider {
    static var previews: some View {

        TestView2()
            .previewDevice("iPhone 13 Pro Max")
            .preferredColorScheme(.light)

//        TestView2()
//            .previewDevice("iPod touch (7th generation)")
//            .preferredColorScheme(.dark)

    }
}




struct OtherTest: ViewModifier {
    
    var rotation: Double // in degrees. Will be used to keep back side of card red until flipped 90 degrees.

    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius:10)
            
            if rotation < 90 { //show front
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: 3)
                
            } else { //else show back
                shape.fill()
            }
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (x: 0, y: 1, z: 0))
    }

}
