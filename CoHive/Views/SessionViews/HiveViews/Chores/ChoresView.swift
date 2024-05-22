//
//  ChoresView.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/22/24.
//


import SwiftUI

struct ChoresView: View {
    
    @StateObject private var viewModel = ChoresViewModel()
    
    var chores: [IdentifiableChore] {
            viewModel.chores.map { IdentifiableChore(chore: $0) }
    }
    
    
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
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
