//
//  SignedOutView.swift
//  CoHive
//
//  Created by Arveen Azhand on 3/23/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import AuthenticationServices


struct SignedOutView: View {
    /// The user should be shown this view when either
    /// 1. Attempting to create a new Hive while not in a valid session
    /// 2. They have just logged out of their account.

    @StateObject private var viewModel = SignedOutViewModel()
    @Binding var showSignInView: Bool
    
    let accent : Color = Color("AccentColor")
    var body: some View {
        VStack {
            NavigationLink {
                SignInUsingEmailView(showSignInView: $showSignInView)
            } label: {
                Text("Sign in using email")
                    .padding()
                    .frame(width: 400, height: 55)
                    .background(content: {
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(Color("BackgroundColor"))
                    })
            }
            
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(
                                scheme: .dark,
                                style: .standard,
                                state: .normal))
            {
                Task {
                    do {
                        try await viewModel.signInGoogle()
                        showSignInView = false
                    } catch {
                        print(error)
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
            .frame(height: 55)
            
            Button {
                Task {
                    do {
                        try await viewModel.signInApple()
                        showSignInView = false
                    } catch {
                        print(error)
                    }
                }
            } label: {
                SignInWithAppleButtonViewRepresentable(type: .default, style: .black)
                    .allowsHitTesting(false)
            }
            .frame(height: 55)
                    
            Spacer()
        }
        .navigationTitle("Sign in")
    }
}


#Preview {
    NavigationStack {
        SignedOutView(showSignInView: .constant(false))
            .font(Font.custom("Josefin Sans", size: 15) )
    }
}
