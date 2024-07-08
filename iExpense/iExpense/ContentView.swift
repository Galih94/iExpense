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

let tapCountKey: String = "Tap"

struct ContentView: View {
    @State private var user = User()
    @State private var showingSheet = false
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    @State private var tapCount = UserDefaults.standard.integer(forKey: tapCountKey)
    
    var body: some View {
        VStack {
            Button("Tap Count: \(tapCount)") {
                tapCount += 1
                
                UserDefaults.standard.set(tapCount, forKey: tapCountKey)
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
