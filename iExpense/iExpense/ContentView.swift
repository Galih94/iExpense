//
//  ContentView.swift
//  iExpense
//
//  Created by Galih Samudra on 08/07/24.
//

import SwiftUI

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
