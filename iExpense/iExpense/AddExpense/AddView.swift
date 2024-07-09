//
//  AddView.swift
//  iExpense
//
//  Created by Galih Samudra on 09/07/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State private var _name: String = ""
    @State private var _type: String = "Personal"
    @State private var _amount: Double = 0.0
    var _expenses: Expenses
    
    let types = ["Personal", "Business"]
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $_name)
                Picker("Type", selection: $_type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", value: $_amount, format: .currency(code: "IDR"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add New Expense")
            .toolbar(content: {
                Button("Save") {
                    let expense = ExpenseItem(name: _name, type: _type, amount: _amount)
                    _expenses._items.append(expense)
                    dismiss()
                }
            })
        }
    }
}

#Preview {
    AddView(_expenses: Expenses())
}
