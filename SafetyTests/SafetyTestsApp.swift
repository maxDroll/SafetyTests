//
//  SafetyTestsApp.swift
//  SafetyTests
//
//  Created by Maxwell K. Droll on 12/3/24.
//

import SwiftUI
import Firebase

@main
struct SafetyTestsApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
