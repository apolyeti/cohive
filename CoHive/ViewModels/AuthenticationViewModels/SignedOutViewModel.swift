//
//  SignedOutViewModel.swift
//  CoHive
//
//  Created by Arveen Azhand on 4/3/24.
//

import Foundation
import CryptoKit
import AuthenticationServices

@MainActor
final class SignedOutViewModel : ObservableObject {
    
    /// ViewModel that handles authentication of the user.
    /// CoHive will be supporting email providers, Signing in with Google, and most importantly, signing in with Apple.

    let signInAppleHelper = SignInUsingAppleHelper()
    
    func signInGoogle() async throws {
        let GoogleSignIn = SignInUsingGoogleHelper()
        let tokens = try await GoogleSignIn.signIn()
        let authDataResult = try await FirestoreManager.shared.signInUsingGoogleCredential(tokens: tokens)
        let user = CoHiveUser(userId: authDataResult.uid, email: authDataResult.email, photoUrl: authDataResult.photoUrl, dateCreated: Date())
        try await UserManager.shared.createNewUser(user: user)
    }
    
    func signInApple() async throws {
        let signInAppleHelper = SignInUsingAppleHelper()
        // Note: this is different than the property of the view model
        let result = try await signInAppleHelper.startSignInWithAppleFlow()
        let authDataResult = try await FirestoreManager.shared.signInUsingAppleCredential(authResult: result)
//        try await UserManager.shared.createNewUser(auth: authDataResult)
        let user = CoHiveUser(userId: authDataResult.uid, email: authDataResult.email, photoUrl: authDataResult.photoUrl, dateCreated: Date())
        try await UserManager.shared.createNewUser(user: user)
    }
    
}

