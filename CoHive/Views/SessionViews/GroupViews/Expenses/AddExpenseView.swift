//
//  AddExpenseView.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/17/24.
//

import SwiftUI

@MainActor
final class AddExpenseViewModel: ObservableObject {
    @Published var itemName: String = ""
    @Published var price: Float = 0.0
    @Published var message: String = ""
}

struct AddExpenseView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = AddExpenseViewModel()
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                    TextField("Name of expense", text: $viewModel.itemName)
                        .frame(width: 150, height: 20)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)

                    Text("$")
                    TextField("Price", value: $viewModel.price, format: .number)
                        .frame(width: 35)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    Spacer()
                }
                TextField("Description", text: $viewModel.message)
                    .frame(width: 240, height: 150, alignment: .topLeading)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Return")
                        }
                    }
                }
            }
                
        }
        .font(Font.custom("Josefin Sans", size: 20))
    }
}

#Preview {
    NavigationStack {
        AddExpenseView()
    }
}
