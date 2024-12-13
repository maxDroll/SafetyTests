//
//  MachineSelectionView.swift
//  SafetyTests
//
//  Created by Eric M. Wetzel on 12/11/24.
//

import SwiftUI

struct MachineSelectionView: View {
    let machines = ["Lathe ", "Mille", "Welder", "Angle Grinder"]
    @AppStorage("name") var name = ""
    @AppStorage("class") var Class = ""
    @State private var selectedMachine: String? = nil
    
    var body: some View {
        VStack {
            Text("Select a Machine by Tapping On It")
            ForEach(machines, id: \.self) { machine in
                Button(action: {
                    selectedMachine = machine
                }) {
                    ZStack{
                        Text(machine)
                        if selectedMachine == machine{
                            Rectangle()
                                .frame(width: 100, height: 100)
                                .foregroundStyle(.blue)
                                .opacity(0.3)
                        }
                    }
                }
            }
            
            
        }
        
    }
    
    struct MachineSelectionView_Previews: PreviewProvider {
        static var previews: some View {
            MachineSelectionView()
        }
    }
}
