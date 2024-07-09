//
//  ContentView.swift
//  iExpense
//
//  Created by Galih Samudra on 08/07/24.
//

import Observation
import SwiftUI

struct ExpenseItem: Identifiable {
    let id: UUID = UUID()
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
    @State private var _showingAddExpanse = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(_expenses._items) { item in
                    Text(item.name)
                }
                .onDelete { index in
                    removeExpense(at: index)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
//                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
//                    _expenses._items.append(expense)
                    _showingAddExpanse.toggle()
                }
            }
            .sheet(isPresented: $_showingAddExpanse, content: {
                AddView()
            })
        }
    }
    
    private func removeExpense(at index: IndexSet) {
        _expenses._items.remove(atOffsets: index)
    }
}

#Preview {
    ContentView()
}
