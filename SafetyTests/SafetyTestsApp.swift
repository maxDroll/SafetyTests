//
//  SafetyTestsApp.swift
//  SafetyTests
//
//  Created by Maxwell K. Droll on 12/3/24.
//

import SwiftUI
import Firebase
import SwiftData

@main
struct SafetyTestsApp: App {
    @StateObject var studentMachineBrain = StudentMachineBrain()
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(studentMachineBrain)
                .modelContainer(for: StudentData.self)
                
        }
    }
}
