//
//  ProfileView.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/8/24.
//

import SwiftUI

struct ProfileView: View {
        
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showSignInView: Bool
    @State private var reloadProfile = false
    
    var body: some View {
        List {
            if let user = viewModel.user {
                Text("UserId: \(user.userId)")
            }
            
            if let email = viewModel.user?.email {
                Text("Email: \(email)")
            }
//            NavigationLink {
//                CreateHiveView()
//            }
            if let hive = viewModel.user?.hive {
                if hive.name != "" {
                    NavigationLink {
                        HiveView()
                    } label: {
                        Text(hive.name)
                    }
                } else {
                    NavigationLink {
                        HiveCreationRedirectView()
                    } label: {
                        Text("Create a new hive")
                    }
                }
            } else {
                NavigationLink {
                    HiveCreationRedirectView()
                } label: {
                    Text("Create a new hive")
                }
            }
        
        }
        .task {
            try? await viewModel.loadCurrentUser()
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    SettingsView(showSignInView: $showSignInView)
                } label: {
                    Image(systemName: "gear")
                        .font(.headline)
                }
            }
        }
        .onAppear {
            reloadProfile.toggle()
        }
            
    }
}

#Preview {
    NavigationStack {
        ProfileView(showSignInView: .constant(false))
    }
}
