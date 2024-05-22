//
//  IdentifiableExpense.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/17/24.
//

import Foundation

struct IdentifiableExpense : Identifiable {
    var id: UUID
    
    var user: CoHiveUser?
    var hive: Hive?
    var dateCreated: Date!
    var item: String!
    var price: Float!
    var message: String?
    
    init(expense: Expense) {
        self.dateCreated = expense.dateCreated
        self.item = expense.item
        self.price = expense.price
        self.message = expense.message
        self.id = UUID()
    }
}
