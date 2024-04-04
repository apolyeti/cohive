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

struct SignedOutView: View {
    @EnvironmentObject var firestoreManager: FirestoreManager
    @StateObject private var viewModel = SignedOutViewModel()
    @Binding var showSignInView: Bool
    
    let accent : Color = Color("AccentColor")
    var body: some View {
        VStack {
            Spacer()
            NavigationLink {
                SignInUsingEmailView(showSignInView: $showSignInView)
            } label: {
                Text("Sign in using email")
            }
            
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(
                                scheme: .dark,
                                style: .standard,
                                state: .normal)) {
                Task {
                    do {
                        try await viewModel.signInGoogle()
                        showSignInView = false
                    } catch {
                        print(error)
                    }
                }
            }
            Spacer()

        }
        .navigationTitle("Sign in")
    }
}


#Preview {
    NavigationStack {
        SignedOutView(showSignInView: .constant(false))
            .font(Font.custom("Josefin Sans", size: 15) )
//            .environmentObject(FirestoreManager())
    }
}
