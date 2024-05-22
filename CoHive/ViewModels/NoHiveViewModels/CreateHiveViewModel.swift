//
//  CreateHiveViewModel.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/22/24.
//

import Foundation

@MainActor
final class CreateHiveViewModel: ObservableObject {
    @Published private(set) var user: CoHiveUser? = nil
    
    @Published var hiveName: String = ""
    @Published var Users : [CoHiveUser] = []
    @Published var Chores : [Chore] = []
    
    func loadCurrentUser() async throws {
        let authDataResult = try FirestoreManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func loadChores(choreNames: [String], user: CoHiveUser) async throws {
        
        for chore in choreNames {
            if chore.isEmpty {
                return
            }
            self.Chores.append(Chore(task: chore, author: user, completed: false))
        }
    }
    
    func createNewHive(choreNames: [String], hiveName: String) async throws {
        guard !hiveName.isEmpty else {
            print("Hive name is empty")
            return
        }
        
        try await loadCurrentUser()
        
        guard let currentUser = user else {
            print("Current user not found")
            return
        }
        
        try await loadChores(choreNames: choreNames, user: currentUser)
        
        
        let hive = Hive(name: hiveName, chores: Chores, users: [currentUser])
        
        try await HiveManager.shared.createNewHive(hive: hive)
    }
    
        
    
}
