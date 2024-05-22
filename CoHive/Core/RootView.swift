//
//  RootView.swift
//  CoHive
//
//  Created by Arveen Azhand on 4/2/24.
//

import SwiftUI

struct RootView: View {
    /// RootVIew will show different views depending on the session of the user.
    /// If user is in a valid session, they should be prompted with either their hive dashboard, or an option to create or join an existing hive.
    /// If user is not in a valid session, they should be shown a view with the option to create or join an existing hive.
    /// Upon attempting to create or join a hive, the user will be prompted to create an account or login.
    
    @State private var showSignInView: Bool = false
    
    var body: some View {
        ZStack {
            if !showSignInView {
                NavigationStack {
                    ProfileView(showSignInView: $showSignInView)
                }
            }
        }
        .onAppear {
            let authUser = try? FirestoreManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                AuthenticationView(showSignInView: $showSignInView)
            }
        }
    }
}

#Preview {
    RootView()
}
