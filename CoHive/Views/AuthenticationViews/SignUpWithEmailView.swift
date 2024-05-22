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
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        guard email == confirmEmail, password == confirmPassword else {
            print("email or password not confirmed")
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
                TextField("Confirm email", text: $viewModel.email)
                    .frame(width: 300, height: 20)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                HStack {
                    TextField("First Name", text: $viewModel.email)
                        .frame(width: 130, height: 20)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    TextField("Last Name", text: $viewModel.email)
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
                SecureField("Confirm Password", text: $viewModel.password)
                    .frame(width: 300, height: 20)
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
                        .foregroundColor(Color("Accent"))
                        .frame(width:300, height: 55)
                        .background(Color("Button"))
                        .cornerRadius(10)
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
