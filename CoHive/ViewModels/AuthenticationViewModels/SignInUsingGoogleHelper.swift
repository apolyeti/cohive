//
//  GoogleHelper.swift
//  CoHive
//
//  Created by Arveen Azhand on 4/3/24.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift


struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
    let profile: GIDProfileData? // this isn't a token, but is information of the user that we would like to use later
}

final class SignInUsingGoogleHelper : ObservableObject {
    
    @MainActor
    func signIn() async throws -> GoogleSignInResultModel {
        guard let topViewController = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let GoogleAuthenticationResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topViewController)
        
        guard let idToken = GoogleAuthenticationResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        
        let accessToken: String = GoogleAuthenticationResult.user.accessToken.tokenString
        
        let profile : GIDProfileData? = GoogleAuthenticationResult.user.profile
        
        let tokens = GoogleSignInResultModel(idToken: idToken,
                                             accessToken: accessToken,
                                             profile: profile
        )
        return tokens
    }
    
}
