//
//  HiveView.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/15/24.
//

import SwiftUI

struct HiveView: View {
    @StateObject private var viewModel = HiveViewModel()
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color("Button"))
    }

    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            VStack {

        
                if let hive = viewModel.hive {
                    Text("\(hive.name)")
                } else {
                    Text("Hive Name")
                }
                
                TabView {
                        Text("Rankings View")
                            .tabItem {
                                Label("Rankings", systemImage: "chart.bar")
                            }
//                    }
                    
//                    Text("Food View")
//                        .tabItem {
//                            Label("Food", systemImage: "fork.knife.circle")
//                        }
                    
//                    Text("Expenses View")
                    ExpensesView()
                        .tabItem {
                            Label("Expenses", systemImage: "dollarsign.circle")
                        }
                    
                    ChoresView()
                        .tabItem {
                            Label("Chores", systemImage: "checklist")
                        }
                }
                

            }.task {
                try? await viewModel.getHive()
            }
        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                NavigationLink {
//                    ProfileView(showSignInView: .constant(false))
//                } label: {
//                    Image(systemName: "gear")
//                        .font(.headline)
//                }
//            }
//        }
        .font(Font.custom("Josefin Sans", size: 20))
    }
}

#Preview {
    NavigationStack {
        HiveView()
    }
}
