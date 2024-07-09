//
//  ContentView.swift
//  iExpense
//
//  Created by Galih Samudra on 08/07/24.
//

import Observation
import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id: UUID = UUID()
    let name: String
    let type: String
    let amount: Double
}

let itemsKey = "itemsKey"

@Observable
class Expenses {
    var _items = [ExpenseItem]() {
        didSet {
            if let data = try? JSONEncoder().encode(_items) {
                UserDefaults.standard.setValue(data, forKey: itemsKey)
            }
        }
    }
    
    init() {
        guard let savedItems = UserDefaults.standard.data(forKey: itemsKey),
           let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) else {
            self._items = []
            return
        }
        self._items = decodedItems
    }
}

struct ContentView: View {
    @State private var _expenses = Expenses()
    @State private var _showingAddExpanse = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(_expenses._items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .foregroundStyle(.primary)
                            Text(item.type)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: "IDR"))
                    }
                }
                .onDelete { index in
                    removeExpense(at: index)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {

                    _showingAddExpanse.toggle()
                }
            }
            .sheet(isPresented: $_showingAddExpanse, content: {
                AddView(_expenses: _expenses)
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
