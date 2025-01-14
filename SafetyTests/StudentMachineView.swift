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
    @State private var hasWatchedVideo: Bool = false
    var body: some View {
        VStack{
            Text(selectedMachine)
            Text("Some Safety Advice")
            VStack(alignment: .leading) {
                            Text("Bullet Points")
                            Text("Bullet Points")
                            
                        }
            ForEach(machines, id:\.self) { machine in
                if machine.name == selectedMachine{
                    Text("\(machine.video)")
                    Text("\(machine.test)")
                    
                    Text("You have \(hasWatchedVideo ? "watched" : "not watched") the video.")
                                            
                }
            }
            Button(action: {
                            hasWatchedVideo.toggle()
                        }) {
                            Text(hasWatchedVideo ? "Mark as Not Watched" : "Mark as Watched")
                                
                        }
                        .padding(.bottom)
        }
        
        .frame(width: 600, height: 1000)
        .onAppear{
            machines = [machineInfo(name: "Mille", test: student.settingStudent().MillTest, video: student.settingStudent().MillVideo),machineInfo(name: "Angle Grinder", test: student.settingStudent().AngleGrinderTest, video: student.settingStudent().AngleGrinderVideo),machineInfo(name: "Lathe", test: student.settingStudent().LatheTest, video: student.settingStudent().LatheVideo),machineInfo(name: "Welder", test: student.settingStudent().WelderTest, video: student.settingStudent().WelderVideo), ]
            
            Text("bullet points")
        }
    }
    struct machineInfo: Hashable{
        var name: String
        var test: Int
        var video: Bool
    }
}
