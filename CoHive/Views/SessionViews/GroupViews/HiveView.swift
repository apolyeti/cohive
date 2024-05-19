//
//  HiveView.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/15/24.
//

import SwiftUI

@MainActor
final class HiveViewModel: ObservableObject {
    func loadCurrentUser() async throws -> CoHiveUser {
        let authDataResult = try FirestoreManager.shared.getAuthenticatedUser()
        return try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func getHive() async throws {
        let currentUser = try await loadCurrentUser()
        self.hive = currentUser.hive
    }
    
    @Published var hive : Hive? = nil
}

struct HiveView: View {
    @StateObject private var viewModel = HiveViewModel()
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color("ButtonColor"))
    }

    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            VStack {

        
                if let hive = viewModel.hive {
                    Text("\(hive.name)")
                } else {
                    Text("Hive Name")
                }
                
                TabView {
//                    ZStack {
//                        Color("BackgroundColor")
                        Text("Rankings View")
                            .tabItem {
                                Label("Rankings", systemImage: "chart.bar")
                            }
//                    }
                    
                    Text("Food View")
                        .tabItem {
                            Label("Food", systemImage: "fork.knife.circle")
                        }
                    
//                    Text("Expenses View")
                    ExpensesView()
                        .tabItem {
                            Label("Expenses", systemImage: "dollarsign.circle")
                        }
                }
                

            }.task {
                try? await viewModel.getHive()
            }
        }
        .font(Font.custom("Josefin Sans", size: 20))
    }
}

#Preview {
    NavigationStack {
        HiveView()
    }
}
