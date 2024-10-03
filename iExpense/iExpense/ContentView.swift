//
//  ContentView.swift
//  iExpense
//
//  Created by Galih Samudra on 08/07/24.
//

import SwiftData
import SwiftUI

struct CustomListExpenseView: View {
    @Query var expenseItem: [ExpenseItem]
    var removeCallback: ((IndexSet) -> Void)?
    
    init(type: String, removeCallback: ((IndexSet) -> Void)?) {
        _expenseItem = Query(filter: #Predicate<ExpenseItem> { item in
            item.type == type
        }, sort: [
            SortDescriptor(\ExpenseItem.name),
            SortDescriptor(\ExpenseItem.amount),
        ])
        self.removeCallback = removeCallback
    }
    
    var body: some View {
        Section {
            ForEach(expenseItem) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .foregroundStyle(.primary)
                        Text(item.type)
                            .foregroundStyle(.secondary)
                    }
                    .accessibilityLabel("\(item.name), IDR \(item.amount)")
                    .accessibilityHint("\(item.type)")
                    Spacer()
                    Text(item.amount, format: .currency(code: "IDR"))
                }
                .foregroundStyle(item.amount < 50_001 ? Color.green : item.amount < 200_001 ? Color.primary : Color.red)
            }
            .onDelete { index in
                removeCallback?(index)
            }
        }
    }
}

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount),
    ]) var expenseItems: [ExpenseItem]
    
    @State private var expenseType: ExpenseType = ExpenseType.Personal
    
    var body: some View {
        NavigationStack {
            List {
                CustomListExpenseView(type: expenseType.rawValue) { index in
                    removeExpense(at: index)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button(expenseType == .Personal ?  "Business" : "Personal") {
                    if expenseType == .Personal {
                        expenseType = .Business
                    } else {
                        expenseType = .Personal
                    }
                }

                NavigationLink {
                    AddView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    private func removeExpense(at index: IndexSet) {
        index.forEach { i in
            modelContext.delete(expenseItems[i])
        }
    }
}

#Preview {
    return ContentView()
}
