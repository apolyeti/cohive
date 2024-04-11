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
    
    var body: some View {
        List {
            Button("log out") {
                Task {
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                    } catch {
                        print("Failed signing out")
                        print(error)
                    }
                }
            }
            if viewModel.authProviders.contains(.email) {
                Button("reset password") {
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
        .navigationTitle("settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSignInView: .constant(true))
    }
}
