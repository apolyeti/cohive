//
//  GIDSignInButton.swift
//  CoHive
//
//  Created by Arveen Azhand on 4/3/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct GIDSignInButton: View {
    var body: some View {
        GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(
                            scheme: .dark,
                            style: .standard,
                            state: .normal)) {
                print("tapped!")
        }
    }
}

#Preview {
    GIDSignInButton()
}
