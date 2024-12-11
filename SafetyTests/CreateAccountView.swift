//
//  CreateAccountView.swift
//  SafetyTests
//
//  Created by Eric M. Wetzel on 12/11/24.
//

import SwiftUICore
import SwiftUI


struct CreateAccountView: View {
    @State private var enterName: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter Name", text: $enterName)
        }
    }
}
