//
//  ContentView.swift
//  iExpense
//
//  Created by Galih Samudra on 08/07/24.
//

import Observation
import SwiftUI

struct ExpenseItem {
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var _items = [ExpenseItem]()
}

struct ContentView: View {
    @State private var _expenses = Expenses()
    var body: some View {
        NavigationStack {
            List {
                ForEach(_expenses._items, id: \.name) { item in
                    Text(item.name)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                    _expenses._items.append(expense)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
