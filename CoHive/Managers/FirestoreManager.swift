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

/// Firestore's authentication functions will be handled here.
/// Note: We do not grab necessary access and ID tokens necessary for credentials here. We obtain these values through the helpers we create for our
/// View models. With the necessary information obtained in those files, we then pass those values into the functions defined here.


/* AUTHDATARESULT MODEL START */
struct AuthDataResultModel {
    
    // We use this custom made struct for retrieving data of the user at login time for later use.
    
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
    
}
/* AUTHDATARESULT MODEL END */

enum AuthProviderOptions: String {
    
    case email = "password"
    
    case google = "google.com"
    
    case apple = "apple.com"
    
}

/* FIRESTORE MANAGER CLASS START */
class FirestoreManager: ObservableObject {
    /// All our Firestore logic will be handled here in this file.
    /// NOTE: We need to create our custom errors for this.
    static let shared = FirestoreManager()
    private init() {}
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    func getProviders() throws -> [AuthProviderOptions] {
        
        guard let providerData = Auth.auth().currentUser?.providerData else {
            throw URLError(.badServerResponse)
            
        }
        
        var providers: [AuthProviderOptions] = []
        
        for provider in providerData {
            
            if let option = AuthProviderOptions(rawValue: provider.providerID) {
                
                providers.append(option)
                
            } else {
                
                assertionFailure("Provider option not found: \(provider.providerID)")
                
            }
        }
        
        return providers
    }
    
    func signOut() throws {
        
        try Auth.auth().signOut()
        
    }
    
}

// MARK: SIGN IN EMAIL
extension FirestoreManager {
    
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


// MARK: SIGN IN SSO
extension FirestoreManager {
    @discardableResult
    func signInUsingGoogleCredential(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let idToken = tokens.idToken
        let accessToken = tokens.accessToken
        
        let authCredential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)

        return try await signInUsingAuthenticationCredential(authCredential: authCredential)
    }
    
    @discardableResult
    func signInUsingAppleCredential(authResult: SignInWithAppleResult) async throws -> AuthDataResultModel {
        let credential = OAuthProvider.appleCredential(withIDToken: authResult.token,
                                                       rawNonce: authResult.nonce,
                                                    fullName: authResult.fullName)
        return try await signInUsingAuthenticationCredential(authCredential: credential)
    }
    
    func signInUsingAuthenticationCredential(authCredential: AuthCredential) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(with: authCredential)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
}
/* FIRESTORE MANAGER CLASS END */
