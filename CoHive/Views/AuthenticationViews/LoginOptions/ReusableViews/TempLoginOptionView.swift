////
////  TempLoginOptionView.swift
////  CoHive
////
////  Created by Arveen Azhand on 3/30/24.
////
//
//import SwiftUI
//
//struct TempLoginOptionView<Destination: View> : View {
//    var destination : any View
//    var label : () -> Label
//    var body: some View {
//        NavigationStack {
//            NavigationLink {
//                destination()
//            } label: {
//                label()
//            }
//        }
//    }
//}
//
//#Preview {
//    TempLoginOptionView(destination: JoinGroupView()) {
//        Text("hello!")
//    }
//}
