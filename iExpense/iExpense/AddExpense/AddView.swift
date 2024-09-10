//
//  AddView.swift
//  iExpense
//
//  Created by Galih Samudra on 09/07/24.
//

import SwiftData
import SwiftUI


enum ExpenseType: String {
    case Personal, Business
}

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @State private var _name: String = "Issue Name"
    @State private var _type: String =  ExpenseType.Personal.rawValue
    @State private var _amount: Double = 0.0
    
    let types = [ExpenseType.Personal.rawValue, ExpenseType.Business.rawValue]
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
                        modelContext.insert(expense)
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
    AddView()
    
}
