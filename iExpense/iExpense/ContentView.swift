//
//  ContentView.swift
//  iExpense
//
//  Created by Galih Samudra on 08/07/24.
//

import SwiftUI
import Observation

@Observable
class User {
    var firstName: String = "Bilbo"
    var lastName: String = "Baggins"
}

struct SecondView: View {
    @Environment(\.dismiss) var dismissView
    let name: String
    var body: some View {
        VStack {
            Text("Hello \(name)")
            Button("Dismiss The Sheet") {
                dismissView()
            }
        }
    }
}

struct ContentView: View {
    @State private var user = User()
    @State private var showingSheet = false
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("row: \($0)")
                    }
                    .onDelete { index in
                        deleteRow(at: index)
                    }
                }
                Button("Add number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .toolbar {
                EditButton()
            }
        }
    }
    
    private func deleteRow(at index: IndexSet) {
        numbers.remove(atOffsets: index)
    }
    
}

#Preview {
    ContentView()
}
