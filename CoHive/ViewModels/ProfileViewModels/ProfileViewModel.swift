//
//  ProfileViewModel.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/8/24.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var user: CoHiveUser? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try FirestoreManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
}
