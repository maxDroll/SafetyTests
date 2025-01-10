//
//  StudentMachineView.swift
//  SafetyTests
//
//  Created by Maxwell K. Droll on 12/13/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct StudentMachineView: View {
    @AppStorage("name") var name = ""
    @AppStorage("class") var Class = ""
    @State var machines:[machineInfo] = []
    @Binding var student: Student
    @Binding var selectedMachine: String
    @Binding var shower: Int
    var body: some View {
        VStack{
            Text(selectedMachine)
            Text("Some Safety Advice")
            ForEach(machines, id:\.self) { machine in
                if machine.name == selectedMachine{
                    Text("\(machine.video)")
                    Text("\(machine.test)")
                    Text("\(shower)")
                }
            }
        }
        .frame(width: 600, height: 1000)
        .onAppear{
            machines = [machineInfo(name: "Mille", test: student.MillTest, video: student.MillVideo),machineInfo(name: "Angle Grinder", test: student.AngleGrinderTest, video: student.AngleGrinderVideo),machineInfo(name: "Lathe", test: student.LatheTest, video: student.LatheVideo),machineInfo(name: "Welder", test: student.WelderTest, video: student.WelderVideo)]
        }
    }
    struct machineInfo: Hashable{
        var name: String
        var test: Int
        var video: Bool
    }
}
