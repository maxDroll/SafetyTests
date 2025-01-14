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
    @StateObject var student: StudentMachineBrain = StudentMachineBrain()
    @Binding var selectedMachine: String
    var body: some View {
        VStack{
            Text(selectedMachine)
            Text("Some Safety Advice")
            ForEach(machines, id:\.self) { machine in
                if machine.name == selectedMachine{
                    Text("\(machine.video)")
                    Text("\(machine.test)")
                }
            }
        }
        .frame(width: 600, height: 1000)
        .onAppear{
            machines = [machineInfo(name: "Mille", test: student.settingStudent().MillTest, video: student.settingStudent().MillVideo),machineInfo(name: "Angle Grinder", test: student.settingStudent().AngleGrinderTest, video: student.settingStudent().AngleGrinderVideo),machineInfo(name: "Lathe", test: student.settingStudent().LatheTest, video: student.settingStudent().LatheVideo),machineInfo(name: "Welder", test: student.settingStudent().WelderTest, video: student.settingStudent().WelderVideo)]
        }
    }
    struct machineInfo: Hashable{
        var name: String
        var test: Int
        var video: Bool
    }
}
