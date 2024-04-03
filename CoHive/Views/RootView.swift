//
//  RootView.swift
//  CoHive
//
//  Created by Arveen Azhand on 4/2/24.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                SettingsView(showSignInView: $showSignInView)
            }
        }
        .onAppear {
            let authUser = try? FirestoreManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                SignedOutView(showSignInView: $showSignInView)
            }
        }
    }
}

#Preview {
    RootView()
}
