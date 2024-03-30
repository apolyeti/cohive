//
//  LoginView.swift
//  CoHive
//
//  Created by Arveen Azhand on 3/23/24.
//

import SwiftUI

struct SignedOutView: View {
    let accent : Color = Color("AccentColor")
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                Spacer()
                Image("CoHiveLogo")
                Spacer()
                LoginOptionView(label: "Sign in using Google") {
                    print("test0")
                }
                LoginOptionView(label: "Register your own account") {
                    print("test1")
                }
                LoginOptionView(label: "Returning user? Login here") {
                    print("test2")
                }
                Spacer()
            }
        }
    }
}


#Preview {
    SignedOutView()
        .font(Font.custom("Josefin Sans", size: 15))
}
