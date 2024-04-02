//
//  SignedOutView.swift
//  CoHive
//
//  Created by Arveen Azhand on 3/23/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

@MainActor
final class AuthenticationViewModel: ObservableObject {
    func signInGoogle() async throws {
        guard let topViewController = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let GoogleSignedInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topViewController)
        
        guard let idToken = GoogleSignedInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        
        let accessToken: String = GoogleSignedInResult.user.accessToken.tokenString
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        // Now with credential, sign into Firebase
    }
}

struct SignedOutView: View {
    @EnvironmentObject var firestoreManager: FirestoreManager
    @StateObject private var viewModel = AuthenticationViewModel()
    
    let accent : Color = Color("AccentColor")
    var body: some View {
        VStack {
            NavigationLink {
                Text("navigation code")
            } label: {
                Text("Sign in using email")
            }
            
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(
                                scheme: .dark,
                                style: .standard,
                                state: .normal)) {
                    print("tapped!")
            }
            Spacer()

        }.navigationTitle("Sign in")
    }
}


#Preview {
    NavigationStack {
        SignedOutView()
            .font(Font.custom("Josefin Sans", size: 15))
            .environmentObject(FirestoreManager())
    }
}
