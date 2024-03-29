//
//  LoginOptionView.swift
//  CoHive
//
//  Created by Arveen Azhand on 3/28/24.
//

import SwiftUI

struct LoginOptionView : View {
                            
    /*
     Properties of LoginOptionView:
     
     label - Will be shown as the text on the button
     
     function - Will handle authentication, these functions
     should be defined in the Controllers/Authentication directory
     */

    let label: String
    let function: () -> Void
    
    var body: some View {
        Button(action: function, label: {
            ZStack {
                Rectangle()
                    .frame(width: 270, height: 35)
                    .foregroundColor(Color("ButtonColor"))
                    .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.accentColor, lineWidth: 1)
                        )
                    .shadow(radius: 3, y: 3)
                Text(label)
            }
        })
        .padding(5)
    }
}

#Preview {
    LoginOptionView(label: "This is a login option!") {
        print("test!")
    }
    .font(Font.custom("Josefin Sans", size: 15))
}
