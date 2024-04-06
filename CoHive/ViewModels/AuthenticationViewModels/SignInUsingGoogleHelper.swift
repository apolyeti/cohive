//
//  GoogleHelper.swift
//  CoHive
//
//  Created by Arveen Azhand on 4/3/24.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift

/// This file stores extra functionality and code that we don't really need in our main file, just to keep things simplified.
/// Any changes which must be made regarding Google authentication and user data when logging in should be handled here.

struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
    
    /* Note: GIDProfileData is not a token used for SSO authentication,
     however is useful data for when user is in a valid session */
    let profile: GIDProfileData?
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
