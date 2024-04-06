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
final class SignedOutViewModel : NSObject, ObservableObject {
    /// ViewModel that handles authentication of the user.
    /// CoHive will be supporting email providers, Signing in with Google, and most importantly, signing in with Apple.
    
    private var currentNonce: String?
    @Published var didSignInUsingApple: Bool = false
    
    func signInGoogle() async throws {
        let GoogleSignIn = SignInUsingGoogleHelper()
        let tokens = try await GoogleSignIn.signIn()
        try await FirestoreManager.shared.signInUsingGoogleCredential(tokens: tokens)
    }
    
    func signInApple() async throws {
        startSignInWithAppleFlow()
        
    }
    
    @available(iOS 13, *)
    func startSignInWithAppleFlow() {
        guard let topViewController = Utilities.shared.topViewController() else {
            return
        }
        
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = topViewController
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

struct SignInWithAppleResult {
    let token: String
    let nonce: String
    let fullName: PersonNameComponents?
}

extension UIViewController: ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}


@available(iOS 13.0, *)
extension SignedOutViewModel: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, 
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            let result = SignInWithAppleResult(token: idTokenString, 
                                               nonce: nonce,
                                               fullName: appleIDCredential.fullName)

            Task {
                do {
                    try await FirestoreManager.shared.signInUsingAppleCredential(authResult: result)
                    didSignInUsingApple = true
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Sign in with Apple errored: \(error)")
    }
    
}
