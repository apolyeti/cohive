//
//  LoginOptionView.swift
//  CoHive
//
//  Created by Arveen Azhand on 3/28/24.
//

import SwiftUI
import Firebase

struct LoginOptionView : View {
    @State var email = ""
    @State var password = ""
                            
    /*
     Properties of LoginOptionView:
     
     label - Will be shown as the text on the button
     
     function - Will handle authentication, these functions
     should be defined in the Controllers/Authentication directory
     */

    let label: String
    let function: () -> Void
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            Button(action: { login() }) {
                Text("Sign in")
            }
        }
        .padding()
//        Button(action: function, label: {
//            ZStack {
//                Rectangle()
//                    .frame(width: 270, height: 35)
//                    .foregroundColor(Color("ButtonColor"))
//                    .border(Color.accentColor)
//                    .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
//                    .shadow(radius: 3, y: 3)
//                Text(label)
//            }
//        })
//        .padding(5)
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
            }
        }
    }
}

#Preview {
    LoginOptionView(label: "Test!") {
        print("test!")
    }
}
