//
//  ContentView.swift
//  SafetyTests
//
//  Created by Maxwell K. Droll on 12/3/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("name") var name = ""
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(name)
        }
        .padding()
        CreateAccountView()
    }
}

#Preview {
    ContentView()
}
