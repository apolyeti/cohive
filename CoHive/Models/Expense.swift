//
//  Expense.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/17/24.
//

import Foundation

/* EXPENSE MODEL START */
struct Expense : Codable {
    
    var user: CoHiveUser?
    var hive: Hive?
    var dateCreated: Date!
    var item: String!
    var price: Float!
    var message: String?
    
    init(user: CoHiveUser, hive: Hive, item: String, price: Float, message: String?) {
        self.user = user
        self.hive = hive
        self.dateCreated = Date()
        self.item = item
        self.price = price
        self.message = message
    }
    
    init(item: String, price: Float, message: String?) {
        self.item = item
        self.price = price
        self.message = message
        self.dateCreated = Date()
        self.user = nil
        self.hive = nil
    }
    
}
/* EXPENSE MODEL END */
