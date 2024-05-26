//
//  SessionView.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/25/24.
//

import SwiftUI

@MainActor
final class SessionViewModel: ObservableObject {
    
    @Published private(set) var user: CoHiveUser? = nil
    
    func loadUserData() async throws {
        let authDataResult = try FirestoreManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
}

struct SessionView: View {
    @Binding var showSignInView: Bool
    @StateObject var viewModel = SessionViewModel()
    var body: some View {
        VStack {
            if let user = viewModel.user {
                if user.hive != nil {
                    HiveView()
                } else {
                    NoHiveView()
                }
            }
        }.task {
            do {
                try await viewModel.loadUserData()
            } catch {
                print("Could not load user data in SessionView. \(error)")
            }
        }
    }
}

#Preview {
    NavigationStack {
        SessionView(showSignInView: .constant(false))
    }
}
