//
//  LoginView.swift
//  CoHive
//
//  Created by Hovhannes Muradyan on 3/29/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

@MainActor
final class SignInUsingEmailViewModel : ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
       
        try await FirestoreManager.shared.createUser(email: email, password: password)
        
    }
}


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
                        try await viewModel.signIn()
                        showSignInView = false
                    } catch {
                        
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
