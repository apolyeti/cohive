//
//  HiveCreationRedirectView.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/15/24.
//

import SwiftUI

/// This solely exists as a method of redirecting the user to the hive they have created when creating a new hive.

struct HiveCreationRedirectView: View {
    @State private var hiveCreated: Bool = false
    @State private var hiveNamed: Bool = false
//    @State private var testPath = NavigationPath([RootView()])
    @Binding var showSignInView: Bool
    @Binding var path: NavigationPath
    
    private var isHiveNotCreated: Binding<Bool> {
        Binding<Bool>(
            get: { !self.hiveCreated },
            set: { self.hiveCreated = !$0 }
        )
    }
    
    
    var body: some View {
        ZStack {
//            if !hiveCreated {
//                NavigationStack {
//                    NameNewHiveView(hiveCreated: $hiveCreated, hiveNamed: $hiveNamed)
//                }
//            } else {
//                NavigationStack {
//                    HiveView(showSignInView: .constant(false))
//                }
//            }
            if hiveCreated {
                NavigationStack(path: $path) {
                    HiveView(showSignInView: $showSignInView, path: $path)
                    
                }
            }
        }
        .fullScreenCover(isPresented: isHiveNotCreated) {
            NavigationStack {
                NameNewHiveView(hiveCreated: $hiveCreated, hiveNamed: $hiveNamed)
            }
        }
    }
}

#Preview {
    NavigationStack {
        HiveCreationRedirectView(showSignInView: .constant(false), path: .constant(NavigationPath()))
    }
}
