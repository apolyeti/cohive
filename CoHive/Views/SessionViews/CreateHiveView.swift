//
//  CreateHiveView.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/15/24.
//

import SwiftUI

@MainActor
final class CreateHiveViewModel : ObservableObject {
    @Published private(set) var user: CoHiveUser? = nil
    
    @Published var hiveName = ""
    @Published var Users : [CoHiveUser] = []
    @Published var Chores : [Chore] = []
    
    func loadCurrentUser() async throws {
        let authDataResult = try FirestoreManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func createNewHive() async throws {
        guard !hiveName.isEmpty else {
            print("Hive name is empty")
            return
        }
        
        try await loadCurrentUser()
        
        guard let currentUser = user else {
            print("Current user not found")
            return
        }
        
        
        
        let hive = Hive(name: hiveName, chores: [], users: [currentUser])
        
        try await HiveManager.shared.createNewHive(hive: hive)
    }

}

struct CreateHiveView: View {
    @StateObject private var viewModel = CreateHiveViewModel()
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            VStack {
                Text("Create a new Hive")
                    .font(.headline)
                TextField("Hive Name", text:$viewModel.hiveName)
                    .frame(width: 350, height: 30)
                    .padding()
                    .background(Color("ButtonColor"))
                    .cornerRadius(5)

                
                Button {
                    Task {
                        do {
                            try await viewModel.createNewHive()
                        }
                    }
                } label: {
                    Text("Create new hive")
                        .padding()
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height:55)
                        .background(Color("AccentColor"))
                        .cornerRadius(10)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CreateHiveView()
    }
}
