//
//  SignInUsingEmailView.swift
//  CoHive
//
//  Created by Hovhannes Muradyan on 3/29/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

@MainActor
final class SignUpUsingEmailViewModel : ObservableObject {
    
    /// ViewModel for email providers. Authenticates through Firebase.
    
    @Published var email = ""
    @Published var confirmEmail = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var firstName = ""
    @Published var lastName = ""
    
    @Published var emailError = ""
    @Published var passwordError = ""
    @Published var loginError = ""
    
    
    func signUp() async throws {
        // Check if user has confirmed their email and password
        emailError = ""
        passwordError = ""
        loginError = ""
        
        

        
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        guard email == confirmEmail else {
            emailError = "Emails do not match"
            return
        }
        
        guard password == confirmPassword else {
            passwordError = "Passwords do not match"
            return
        }
       
        let authDataResult = try await FirestoreManager.shared.createUser(email: email, password: password)
        let user = CoHiveUser(auth: authDataResult, first: firstName, last: lastName)
        try await UserManager.shared.createNewUser(user: user)
        
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
       
        try await FirestoreManager.shared.signInUser(email: email, password: password)
        
    }
    
}

struct SignUpUsingEmailView: View {
    /// This view will be shown when a user decides to log in using their email provider, which requires a password as well.
    @StateObject private var viewModel = SignUpUsingEmailViewModel()
    @Binding var showSignInView : Bool
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            VStack {
                Spacer()
                Image("CoHive")
                Text("Sign up using your email address")
                    .padding(5)
                    .font(Font.custom("Josefin Sans", size: 20))
                TextField("Email", text: $viewModel.email)
                    .frame(width: 300, height: 20)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                TextField("Confirm email", text: $viewModel.confirmEmail)
                    .frame(width: 300, height: 20)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                
                if !viewModel.emailError.isEmpty {
                    Text(viewModel.emailError)
                        .foregroundStyle(Color.red)
                        .font(.caption)
                }
                HStack {
                    TextField("First Name", text: $viewModel.firstName)
                        .frame(width: 130, height: 20)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    TextField("Last Name", text: $viewModel.lastName)
                        .frame(width: 130, height: 20)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
                SecureField("Password", text: $viewModel.password)
                    .frame(width: 300, height: 20)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                SecureField("Confirm Password", text: $viewModel.confirmPassword)
                    .frame(width: 300, height: 20)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                if !viewModel.passwordError.isEmpty {
                    Text(viewModel.passwordError)
                        .foregroundStyle(Color.red)
                        .font(.caption)
                }
                
                Button {
                    Task {
                        do {
                            try await viewModel.signUp()
                            return
                        } catch {
                            print("User is either signed up, or invalid data inputted!")
                            viewModel.loginError = "Email already in use"
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
                        .foregroundColor(Color("Accent"))
                        .frame(width:300, height: 55)
                        .background(Color("Button.primary"))
                        .cornerRadius(10)
                }
                if !viewModel.loginError.isEmpty {
                    Text(viewModel.loginError)
                        .foregroundStyle(Color.red)
                        .font(.caption)
                }
                Spacer()
                
            }
        }
    }
    
    
}

#Preview {
    NavigationStack {
        SignUpUsingEmailView(showSignInView: .constant(false))
    }
}
