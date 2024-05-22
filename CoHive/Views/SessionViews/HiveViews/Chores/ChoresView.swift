//
//  ChoresView.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/22/24.
//


import SwiftUI

@MainActor
final class ChoresViewModel : ObservableObject {
    
    @Published var hive: Hive?
    @Published var chores: [Chore] = []
    
    
    func loadCurrentUser() async throws -> CoHiveUser {
        let authDataResult = try FirestoreManager.shared.getAuthenticatedUser()
        return try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func getHive() async throws {
        let currentUser = try await loadCurrentUser()
        self.hive = currentUser.hive
    }
    
    func loadHiveChores() async throws {
        try await getHive()
        self.chores = self.hive!.chores
    }
}

struct ChoresView: View {
    
    @StateObject private var viewModel = ChoresViewModel()
    
    var chores: [IdentifiableChore] {
            viewModel.chores.map { IdentifiableChore(chore: $0) }
    }
    
    
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            ScrollView {
                VStack {
                    ForEach(chores) { chore in
                        ChoreItemView(chore: chore)
                    }
                    NavigationLink {
                        AddExpenseView()
                    } label: {
                        Text("Add new chore")
                    }
                }
            }
        }.task {
            do {
                try await viewModel.loadHiveChores()
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ChoresView()
}
