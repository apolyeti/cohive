//
//  NoHiveView.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/25/24.
//

import SwiftUI

struct NoHiveView: View {
    @Binding var showSignInView: Bool
    @Binding var path: NavigationPath
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            VStack {
                Spacer()
                Text("Looks like you're not currently in a hive.")
                    .multilineTextAlignment(.center)
                HStack {
                    NavigationLink {
                        HiveCreationRedirectView(showSignInView: $showSignInView, path: $path)
                    } label: {
                        Label("Create", systemImage: "plus")
                    }
                    Text("or")
                    NavigationLink {
                        EmptyView()
                    } label: {
                        Label("Join a hive", systemImage: "person.2.fill")
                    }
                }
                Spacer()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    ProfileView(showSignInView: $showSignInView, path: $path)
                } label: {
                    Image(systemName: "person.circle")
                        .font(.headline)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        NoHiveView(showSignInView: .constant(false), path: .constant(NavigationPath()))
            .font(Font.custom("Josefin Sans", size: 20))
    }
}
