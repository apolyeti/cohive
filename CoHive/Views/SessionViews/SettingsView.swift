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
        .navigationTitle("settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSignInView: .constant(true))
    }
}
