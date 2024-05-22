//
//  SettingsViewModel.swift
//  CoHive
//
//  Created by Arveen Azhand on 4/3/24.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published var authProviders: [AuthProviderOptions] = []
    
    func loadAuthProviders() {
        if let providers = try? FirestoreManager.shared.getProviders() {
            authProviders = providers
        }
        
    }
    
    func signOut() throws {
        try FirestoreManager.shared.signOut()
    }

    
    func resetPassword() async throws {
        let authUser = try FirestoreManager.shared.getAuthenticatedUser()
        guard let email = authUser.email else {
            throw URLError(.badServerResponse)
        }
        try await FirestoreManager.shared.sendPasswordReset(email: email)
    }
    
}
