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
    var body: some View {
        VStack {
            Text("Hello world")
        }
    }
}

#Preview {
    ContentView()
}
