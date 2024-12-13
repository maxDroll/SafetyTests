//
//  ContentView.swift
//  SafetyTests
//
//  Created by Maxwell K. Droll on 12/3/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("name") var name = ""
    @AppStorage("class") var Class = ""
    var body: some View {
        if name != ""{
            HStack{
                MachineSelectionView()
            }
        }else{
            CreateAccountView()
        }
    }
}

#Preview {
    ContentView()
}
