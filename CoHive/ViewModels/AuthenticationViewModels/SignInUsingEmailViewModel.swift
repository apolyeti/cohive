//
//  SignInUsingEmailViewModel.swift
//  CoHive
//
//  Created by Arveen Azhand on 4/3/24.
//

import Firebase
import FirebaseAuth

@MainActor
final class SignInUsingEmailViewModel : ObservableObject {
    
    /// ViewModel for email providers. Authenticates through Firebase.
    
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
       
        let authDataResult = try await FirestoreManager.shared.createUser(email: email, password: password)
        let user = CoHiveUser(auth: authDataResult)
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
