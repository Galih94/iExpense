//
//  AddView.swift
//  iExpense
//
//  Created by Galih Samudra on 09/07/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State private var _name: String = "Issue Name"
    @State private var _type: String = "Personal"
    @State private var _amount: Double = 0.0
    var _expenses: Expenses
    
    let types = ["Personal", "Business"]
    var body: some View {
        NavigationStack {
            Form {
                Picker("Type", selection: $_type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", value: $_amount, format: .currency(code: "IDR"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($_name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let expense = ExpenseItem(name: _name, type: _type, amount: _amount)
                        if _type == "Personal" {
                            _expenses._personalItem.append(expense)
                        } else {
                            _expenses._businessItem.append(expense)
                        }
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            })
        }
    }
}

#Preview {
    AddView(_expenses: Expenses())
}
