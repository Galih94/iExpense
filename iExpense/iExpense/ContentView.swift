//
//  ContentView.swift
//  iExpense
//
//  Created by Galih Samudra on 08/07/24.
//

import SwiftUI

struct User {
    var firstName: String = "Bilbo"
    var lastName: String = "Baggins"
}

struct ContentView: View {
    @State private var user = User()
    
    var body: some View {
        VStack {
            Text("Hello, \(user.firstName) \(user.lastName)")
            
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
