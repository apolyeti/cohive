//
//  SignedOutViewModel.swift
//  CoHive
//
//  Created by Arveen Azhand on 4/3/24.
//

import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

@MainActor
final class SignedOutViewModel: ObservableObject {
    func signInGoogle() async throws {
        guard let topViewController = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let GoogleSignedInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topViewController)
        
        guard let idToken = GoogleSignedInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        
        let accessToken: String = GoogleSignedInResult.user.accessToken.tokenString
        
        let _ = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        // Now with credential, sign into Firebase
    }
}
