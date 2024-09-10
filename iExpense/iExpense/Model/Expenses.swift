//
//  Expenses.swift
//  iExpense
//
//  Created by Galih Samudra on 02/09/24.
//

import Observation
import Foundation
import SwiftData

@Model
class ExpenseItem {
    var id: UUID = UUID()
    let name: String
    let type: String
    let amount: Double
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}

let personalItemsKey = "personalItemsKey"
let businessItemsKey = "businessItemsKey"

//@Model
//class Expenses {
//    var _personalItem: [ExpenseItem]
//    var _businessItem: [ExpenseItem]
//    
//    init(_personalItem: [ExpenseItem], _businessItem: [ExpenseItem]) {
//        self._personalItem = _personalItem
//        self._businessItem = _businessItem
//    }
//}
