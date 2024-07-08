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
let tapCountAppStorageKey: String = "TapAppStorageKey"

struct ContentView: View {
    @State private var user = User()
    @State private var showingSheet = false
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    @State private var tapCount = UserDefaults.standard.integer(forKey: tapCountKey)
    @AppStorage(tapCountAppStorageKey) private var tapCountAppStorage = 0
    
    var body: some View {
        VStack {
            Button("Tap Count AppStorage: \(tapCountAppStorage)") {
                tapCountAppStorage += 1
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
