//
//  ExpenseViewModel.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/22/24.
//

import Foundation

@MainActor
final class AddExpenseViewModel: ObservableObject {
    @Published var itemName: String = ""
    @Published var price: Float = 0.0
    @Published var message: String = ""
}
