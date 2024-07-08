//
//  ContentView.swift
//  iExpense
//
//  Created by Galih Samudra on 08/07/24.
//

import SwiftUI
import Observation

struct User: Codable {
    var firstName: String
    var lastName: String
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

let key: String = "Key"

struct ContentView: View {
    @State private var user = User(firstName: "", lastName: "")
    
    var body: some View {
        VStack {
            Text("Saved user: \(getUserFirstName) \(getUserLastName)")
            TextField("First Name", text: $user.firstName)
            TextField("Last Name", text: $user.lastName)
            Button("Save") {
                saveUser()
            }
        }
    }
    
    private func saveUser() {
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(user) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    private var getUserFirstName: String {
        
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: key), let user = try? decoder.decode(User.self, from: data) {
            
            return "\(user.firstName)"
        } else {
            return ""
        }
    }
    
    private var getUserLastName: String {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: key), let user = try? decoder.decode(User.self, from: data) {
            return user.lastName
        } else {
            return ""
        }
    }
    
}

#Preview {
    ContentView()
}
