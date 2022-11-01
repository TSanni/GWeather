//
//  SwiftUIView2.swift
//  Weather
//
//  Created by Tomas Sanni on 5/15/22.
//

import SwiftUI
import SwiftUIMailView


struct SendMailView: View {
    
    @State private var mailData = ComposeMailData(subject: "Feedback from iOS",
                                                  recipients: ["tomas.sanni@yahoo.com"],
                                                  message: "Ask a question or submit feedback.",
                                                  attachments: [])
    @State private var showMailView = false

     var body: some View {
         Button(action: {
             showMailView.toggle()
         }) {
             Text("Contact Support")
//                 .foregroundColor(Color(hue: 0.456, saturation: 0.97, brightness: 0.79))

         }
         .disabled(!MailView.canSendMail)
         .sheet(isPresented: $showMailView) {
             MailView(data: $mailData) { result in
                 print(result)
             }
         }
     }
}

struct SendMailView_Previews: PreviewProvider {
    static var previews: some View {
        SendMailView()
    }
}
