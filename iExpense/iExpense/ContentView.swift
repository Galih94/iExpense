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
    var body: some View {
        VStack {
            Button("Show The Sheet") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                SecondView(name: "Galih")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
