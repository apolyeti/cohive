//
//  ProfileViewModel.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/8/24.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var user: CoHiveUser? = nil
    @Published private(set) var authData: AuthDataResultModel? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try FirestoreManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func loadAuthDataResult() async throws {
        self.authData = try FirestoreManager.shared.getAuthenticatedUser()
    }
    
}
