//
//  Expenses.swift
//  iExpense
//
//  Created by Galih Samudra on 02/09/24.
//

import Observation
import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id: UUID = UUID()
    let name: String
    let type: String
    let amount: Double
}

let personalItemsKey = "personalItemsKey"
let businessItemsKey = "businessItemsKey"

@Observable
class Expenses {
    var _personalItem: [ExpenseItem] {
        didSet {
            if let data = try? JSONEncoder().encode(_personalItem) {
                UserDefaults.standard.setValue(data, forKey: personalItemsKey)
            }
        }
    }
    
    var _businessItem: [ExpenseItem] {
        didSet {
            if let data = try? JSONEncoder().encode(_businessItem) {
                UserDefaults.standard.setValue(data, forKey: businessItemsKey)
            }
        }
    }
    
    init() {
        
        if let savedItems = UserDefaults.standard.data(forKey: personalItemsKey),
           let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
            self._personalItem = decodedItems
        } else {
            self._personalItem = []
        }
        
        if let savedItems = UserDefaults.standard.data(forKey: businessItemsKey),
           let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
            self._businessItem = decodedItems
        } else {
            self._businessItem = []
        }
    }
}
