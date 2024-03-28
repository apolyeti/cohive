//
//  ContentView.swift
//  CoHive
//
//  Created by Arveen Azhand on 3/23/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    let accent : Color = Color("AccentColor")
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                Image("CoHiveLogo")
                Spacer()
                Text("teHello workdst")
                    .foregroundColor(.red)
                Spacer()
            }
        }
    }
}


#Preview {
    ContentView()
}
