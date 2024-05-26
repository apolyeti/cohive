//
//  NoHiveView.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/25/24.
//

import SwiftUI

struct NoHiveView: View {
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            VStack {
                Spacer()
                Text("Looks like you're not currently in a hive.")
                    .multilineTextAlignment(.center)
                HStack {
                    NavigationLink {
                        EmptyView()
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
                    SettingsView(showSignInView: .constant(false))
                } label: {
                    Image(systemName: "gear")
                        .font(.headline)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        NoHiveView()
            .font(Font.custom("Josefin Sans", size: 20))
    }
}
