//
//  CreateHiveView.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/21/24.
//

import SwiftUI

@MainActor
final class CreateHiveViewModel: ObservableObject {
    @Published private(set) var user: CoHiveUser? = nil
    
    @Published var hiveName: String = ""
    @Published var Users : [CoHiveUser] = []
    @Published var Chores : [Chore] = []
    
    func loadCurrentUser() async throws {
        let authDataResult = try FirestoreManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func loadChores(choreNames: [String], user: CoHiveUser) async throws {
        
        for chore in choreNames {
            if chore.isEmpty {
                return
            }
            self.Chores.append(Chore(task: chore, author: user, completed: false))
        }
    }
    
    func createNewHive(choreNames: [String], hiveName: String) async throws {
        guard !hiveName.isEmpty else {
            print("Hive name is empty")
            return
        }
        
        try await loadCurrentUser()
        
        guard let currentUser = user else {
            print("Current user not found")
            return
        }
        
        try await loadChores(choreNames: choreNames, user: currentUser)
        
        
        let hive = Hive(name: hiveName, chores: Chores, users: [currentUser])
        
        try await HiveManager.shared.createNewHive(hive: hive)
    }
    
        
    
}

struct CreateHiveView: View {
    @Binding var hiveName: String
    @Binding var hiveCreated: Bool
    @State private var choreCount : Int = 0
    @State private var choreNames: [String] = []
    @StateObject private var viewModel = CreateHiveViewModel()
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            VStack {
                Text("Any chores to add?")
                    .font(Font.custom("Josefin Sans", size: 25))
                
                ForEach(0..<choreCount, id: \.self) { index in
                    TextField("Chore \(index + 1)", text: Binding(
                        get: {
                            if index < choreNames.count {
                                return choreNames[index]
                            } else {
                                return ""
                            }
                        },
                        set: { newValue in
                            if index < choreNames.count {
                                choreNames[index] = newValue
                            } else {
                                choreNames.append(newValue)
                            }
                        }
                    ))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                }
                
                HStack {
                    Button {
                        Task {
                            choreCount += 1
                            choreNames.append("")
                        }
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                    }.disabled(choreCount >= 10)
                    Button {
                        Task {
                            choreCount -= 1
                            choreNames.removeLast()
                        }
                    } label: {
                        Image(systemName: "minus.circle")
                            .padding()
                    }.disabled(choreCount == 0)
                }
                Button {
                    Task {
                        try await viewModel.createNewHive(choreNames: choreNames, hiveName: hiveName)
                        hiveCreated = true
                    }
                } label: {
                    if (choreCount == 0) {
                        Text("Maybe later")
                            .padding()
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(height:55)
                            .background(Color("AccentColor"))
                            .cornerRadius(10)
                    } else {
                        Text("Create Hive")
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
}

#Preview {
    
    CreateHiveView(hiveName: .constant("Sextuplets"), hiveCreated: .constant(false))
}
