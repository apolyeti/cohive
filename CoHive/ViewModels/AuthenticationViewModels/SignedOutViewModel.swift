//
//  SignedOutViewModel.swift
//  CoHive
//
//  Created by Arveen Azhand on 4/3/24.
//

import Foundation

@MainActor
final class SignedOutViewModel : ObservableObject {
    func signInGoogle() async throws {
        
        let GoogleSignIn = SignInUsingGoogleHelper()
        
        let tokens = try await GoogleSignIn.signIn()
        
        try await FirestoreManager.shared.signInUsingGoogleCredential(tokens: tokens)
        
    }
}
