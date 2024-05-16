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

    
    var body: some View {
        
        VStack {
            if let hive = viewModel.hive {
                Text("Welcome to \(hive.name)")
            }
        }.task {
            try? await viewModel.getHive()
        }
    }
}

#Preview {
    HiveView()
}
