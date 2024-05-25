//
//  CreateHiveView.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/21/24.
//

import SwiftUI


struct CreateHiveView: View {
    @Binding var hiveName: String
    @Binding var hiveCreated: Bool
    @State private var choreCount : Int = 0
    @State private var choreNames: [String] = []
    @StateObject private var viewModel = CreateHiveViewModel()
    let disabled = false
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
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
                    .frame(width: 250, height: 5)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
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
                    }.disabled(choreCount >= 10 || (choreCount > 0 && choreNames[choreCount-1].isEmpty))
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
                    let label = choreCount == 0 ? "Maybe later" : "Create Hive"
                
                    Text(label)
                        .padding()
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height:55)
                        .background(Color("Accent2"))
                        .cornerRadius(10)
                   
                }
            }
        }
    }
}

#Preview {
    
    CreateHiveView(hiveName: .constant("Sextuplets"), hiveCreated: .constant(false))
}
