//
//  HiveViewModel.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/22/24.
//

import Foundation

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
