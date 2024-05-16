//
//  SignInUsingEmailView.swift
//  CoHive
//
//  Created by Hovhannes Muradyan on 3/29/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SignInUsingEmailView: View {
    /// This view will be shown when a user decides to log in using their email provider, which requires a password as well.
    @StateObject private var viewModel = SignInUsingEmailViewModel()
    @Binding var showSignInView : Bool
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            VStack {
                
                TextField("Email:", text: $viewModel.email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                
                SecureField("Password:", text: $viewModel.password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                
                Button {
                    Task {
                        do {
                            try await viewModel.signUp()
                            showSignInView = false
                            return
                        } catch {
                            print("User is either signed up, or invalid data inputted!")
                        }
                        
                        do {
                            try await viewModel.signIn()
                            showSignInView = false
                            return
                        } catch {
                            print(error)
                        }
                    }
                } label: {
                    Text("Sign in")
                        .font(.headline)
                        .foregroundColor(Color("AccentColor"))
                        .frame(width:300, height: 55)
                        .background(Color("ButtonColor"))
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Sign in using email")
        }
    }
    
    
}

#Preview {
    NavigationStack {
        SignInUsingEmailView(showSignInView: .constant(false))
    }
}
