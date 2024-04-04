//
//  FirebaseManager.swift
//  CoHive
//
//  Created by Hovhannes Muradyan on 3/28/24.
//

import Foundation
import FirebaseFirestoreInternalWrapper
import FirebaseFirestore
import FirebaseAuth
import Firebase

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

class FirestoreManager: ObservableObject {
    
    static let shared = FirestoreManager()
    private init() {}
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func sendPasswordReset(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func updateUserPassword(newPassword: String) async throws {
        guard let authenticatedUser = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        try await authenticatedUser.updatePassword(to: newPassword)
    }
    
    func updateUserEmail(newEmail: String) async throws {
        guard let authenticatedUser = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        guard let userEmail = authenticatedUser.email else {
            throw URLError(.badServerResponse)
        }
        try await authenticatedUser.sendEmailVerification(beforeUpdatingEmail: userEmail)
    }
    
}
