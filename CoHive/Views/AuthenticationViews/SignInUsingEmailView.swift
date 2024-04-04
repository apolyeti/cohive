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
    @StateObject private var viewModel = SignInUsingEmailViewModel()
    @Binding var showSignInView : Bool
    
    var body: some View {
        VStack {
            
            TextField("Email:", text: $viewModel.email)
                .padding()
                .background(Color.gray)
                .cornerRadius(10)
            
            SecureField("Password:", text: $viewModel.password)
                .padding()
                .background(Color.gray)
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
                    .frame(height:55)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Sign in using email")
    }
    
    
}

#Preview {
    NavigationStack {
        SignInUsingEmailView(showSignInView: .constant(false))
    }
}
