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


struct AuthenticationView: View {
    /// The user should be shown this view when either
    /// 1. Attempting to create a new Hive while not in a valid session
    /// 2. They have just logged out of their account.

    @StateObject private var viewModel = SignedOutViewModel()
    @Binding var showSignInView: Bool
    
    let accent : Color = Color("Accent")
    let button : Color = Color("Button")
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            VStack {
                Spacer()
                Image("CoHiveLogo")
                Spacer()
                
                NavigationLink {
                    SignInUsingEmailView(showSignInView: $showSignInView)
                } label: {
                    Label("Sign in with email", systemImage: "envelope.fill")
                        .font(Font.custom("Josefin Sans", size: 18))
                        .frame(width: 270, height: 10)
                        .padding()
                        .background(button)
                }
                
                GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(
                    scheme: .light,
                    style: .wide,
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
                
                //            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
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
                .frame(height: 40)
                
                Spacer()
            }
            .frame(width: 300)
        }
    }
//        .background(Color("BackgroundColor"))
}


#Preview {
    NavigationStack {
        AuthenticationView(showSignInView: .constant(false))
            .font(Font.custom("Josefin Sans", size: 20) )
    }
}
