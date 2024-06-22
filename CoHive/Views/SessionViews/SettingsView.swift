//
//  SettingsView.swift
//  CoHive
//
//  Created by Arveen Azhand on 4/2/24.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    @Binding var path : NavigationPath
    
    var body: some View {
        ZStack {
//            Color("Background")
            List {
                Button("Sign out") {
                    Task {
                        do {
                            try viewModel.signOut()
                            showSignInView = true
                            print("User signed out")
                            path = NavigationPath([RootView()])
                            print(path)
                        } catch {
                            print("Failed signing out")
                            print(error)
                        }
                    }
                }
                if viewModel.authProviders.contains(.email) {
                    Button("Reset Password") {
                        Task {
                            do {
                                try await viewModel.resetPassword()
                                print("PASSWORD RESET")
                            } catch {
                                print("Failed signing out")
                                print(error)
                            }
                        }
                    }
                }
            }
            .onAppear {
                viewModel.loadAuthProviders()
            }
            .navigationTitle("Settings")
        }
        
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSignInView: .constant(true), path: .constant(NavigationPath()))
    }
}
