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

struct CustomListExpenseView: View {
    var _expenseItem: [ExpenseItem]
    var _removeCallback: ((IndexSet) -> Void)?
    var body: some View {
        Section {
            ForEach(_expenseItem) { item in
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
                .foregroundStyle(item.amount < 50_001 ? Color.green : item.amount < 200_001 ? Color.primary : Color.red)
            }
            .onDelete { index in
                _removeCallback?(index)
            }
        }
    }
}

struct ContentView: View {
    @State private var _expenses = Expenses()
    
    var body: some View {
        NavigationStack {
            List {
                CustomListExpenseView(_expenseItem: _expenses._personalItem) { index in
                    removeExpensePersonal(at: index)
                }
                CustomListExpenseView(_expenseItem: _expenses._businessItem) { index in
                    removeExpenseBusiness(at: index)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink {
                    AddView(_expenses: _expenses)
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Image(systemName:  "plus")
                }
            }
        }
    }
    
    private func removeExpensePersonal(at index: IndexSet) {
        _expenses._personalItem.remove(atOffsets: index)
    }
    
    private func removeExpenseBusiness(at index: IndexSet) {
        _expenses._businessItem.remove(atOffsets: index)
    }
}

#Preview {
    ContentView()
}
