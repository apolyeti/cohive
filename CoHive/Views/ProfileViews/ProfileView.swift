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
    @Binding var path: NavigationPath
    @State private var reloadProfile = false
    
    var body: some View {
        ZStack {
            Color("Background")
            List {
                if let user = viewModel.user {
                    Text("UserId: \(user.userId)")
                }
                
                if let email = viewModel.user?.email {
                    if viewModel.authData?.provider != "apple" {
                        Text("Email: \(email)")
                    }
                }
                
                if let hive = viewModel.user?.hive {
                    if hive.name != "" {
//                        NavigationLink {
//                            HiveView()
//                        } label: {
//                            Text(hive.name)
//                        }
                    } else {
                        NavigationLink {
                            HiveCreationRedirectView(showSignInView: $showSignInView, path: $path)
                        } label: {
                            Text("Create a new hive")
                        }
                    }
                } else {
                    NavigationLink {
                        HiveCreationRedirectView(showSignInView: $showSignInView, path: $path)
                    } label: {
                        Text("Create a new hive")
                    }
                }
                
            }
            .task {
                try? await viewModel.loadCurrentUser()
                try? await viewModel.loadAuthDataResult()
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        SettingsView(showSignInView: $showSignInView, path: $path)
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
}

#Preview {
    NavigationStack {
        ProfileView(showSignInView: .constant(false), path: .constant(NavigationPath()))
    }
}
