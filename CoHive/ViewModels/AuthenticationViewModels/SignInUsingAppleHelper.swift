//
//  SignInUsingAppleHelper.swift
//  CoHive
//
//  Created by Arveen Azhand on 4/6/24.
//

import Foundation
import SwiftUI
import UIKit
import AuthenticationServices
import CryptoKit

/* SignInWithAppleResult START */
struct SignInWithAppleResult {
    let token: String
    let nonce: String
    let fullName: PersonNameComponents?
    let email: String?
}
/* SignInWithAppleResult END */

/* SignInWithAppleButtonViewRepresentable START */
struct SignInWithAppleButtonViewRepresentable: UIViewRepresentable {
    
    let type: ASAuthorizationAppleIDButton.ButtonType
    let style: ASAuthorizationAppleIDButton.Style
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        ASAuthorizationAppleIDButton(authorizationButtonType: type,
                                            authorizationButtonStyle: style)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
        
    }
    
}
/* SignInWithAppleButtonViewRepresentable END */

/* SignInUsingAppleHelper Class START */
@MainActor
final class SignInUsingAppleHelper: NSObject {
    
    /// This helper should be just about reusable for most future Swift iOS projects using Firestore.
    /// This will be used by the SignedOutViewModel for Apple SSO authentication
    /// Should grab the user's full name, email, and other necessary data required for authentication. Otherwise, throw an error.
    
    private var currentNonce: String?
    private var completionHandler: ((Result<SignInWithAppleResult, Error>) -> Void)? = nil
    
    func startSignInWithAppleFlow() async throws -> SignInWithAppleResult {
        try await withCheckedThrowingContinuation { continuation in
            self.startSignInWithAppleFlow { result in
                switch result {
                case .success(let signInWithAppleResult):
                    continuation.resume(returning: signInWithAppleResult)
                    return
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    @available(iOS 13, *)
    func startSignInWithAppleFlow(completion: @escaping (Result<SignInWithAppleResult, Error>) -> Void) {
        guard let topViewController = Utilities.shared.topViewController() else {
            completion(.failure(URLError(.badServerResponse)))
            return
        }
        
        let nonce = randomNonceString()
        currentNonce = nonce
        completionHandler = completion
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = topViewController as any ASAuthorizationControllerPresentationContextProviding
        authorizationController.performRequests()
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError(
                "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
        }
        
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        
        let nonce = randomBytes.map { byte in
            // Pick a random character from the set, wrapping around if needed.
            charset[Int(byte) % charset.count]
        }
        
        return String(nonce)
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}
/* SignInUsingAppleHelper Class END */

/* UIViewController Extension START */
extension UIViewController: ASAuthorizationControllerPresentationContextProviding {
    /// We need this for the modal that appears when attempting to login using Apple.
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
/* SignInUsingAppleHelper Extension END */

/* SignInUsingAppleHelper Extension START */
@available(iOS 13.0, *)
extension SignInUsingAppleHelper: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // NOTE: We need to create our custom errors for this.
            guard let nonce = currentNonce else {
                completionHandler?(.failure(URLError(.badServerResponse)))
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                completionHandler?(.failure(URLError(.badServerResponse)))
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                completionHandler?(.failure(URLError(.badServerResponse)))
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            let result = SignInWithAppleResult(token: idTokenString,
                                               nonce: nonce,
                                               fullName: appleIDCredential.fullName,
                                               email: appleIDCredential.email
            )
            completionHandler?(.success(result))

        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Sign in with Apple errored: \(error)")
    }
    
}
/* SignInUsingAppleHelper Extension END */
