//
//  ProfileViewModel.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/8/24.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var user: AuthDataResultModel? = nil
    
    func loadCurrentUser() throws {
        self.user = try FirestoreManager.shared.getAuthenticatedUser()
    }
    
}
