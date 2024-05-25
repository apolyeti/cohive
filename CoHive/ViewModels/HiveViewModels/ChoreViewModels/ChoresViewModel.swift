//
//  ChoreViewModel.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/22/24.
//

import Foundation

@MainActor
final class ChoresViewModel : ObservableObject {
    
    @Published var hive: Hive?
    @Published var chores: [Chore] = []
    @Published var gotChores : Bool = false
    
    
    func loadCurrentUser() async throws -> CoHiveUser {
        let authDataResult = try FirestoreManager.shared.getAuthenticatedUser()
        return try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func getHive() async throws {
        let currentUser = try await loadCurrentUser()
        self.hive = currentUser.hive
    }
    
    func loadHiveChores() async throws {
        try await getHive()
        self.chores = self.hive!.chores
        self.gotChores = true
    }
}
