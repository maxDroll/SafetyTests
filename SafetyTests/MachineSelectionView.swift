//
//  MachineSelectionView.swift
//  SafetyTests
//
//  Created by Eric M. Wetzel on 12/11/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct MachineSelectionView: View {
    let machines = ["Lathe", "Mille", "Welder", "Angle Grinder"]
    @State var shower = -1
    @AppStorage("name") var name = ""
    @AppStorage("class") var Class = ""
    @State private var selectedMachine: String = ""
    @FirestoreQuery(collectionPath: "Students") var students:[Student]
    @State var student: Student = Student(AngleGrinderTest: -1, AngleGrinderVideo: false, Class: "Till", LatheTest: -1, LatheVideo: false, MillTest: -1, MillVideo: false, WelderTest: -1, WelderVideo: false, name: "Bill", Teacher: false)
    var body: some View {
        HStack(spacing:0){
            VStack(spacing:0){
                Rectangle()
                    .frame(width:500,height:3,alignment: .leading)
                ForEach(machines, id: \.self) { machine in
                    Button(action: {
                        selectedMachine = machine
                    },label:  {
                        ZStack{
                            Text(machine)
                                .foregroundStyle(.black)
                                .frame(width:460,height:203,alignment: .leading)
                                .font(.system(size: 50))
                            if selectedMachine == machine{
                                Rectangle()
                                    .frame(width: 500, height: 203)
                                    .foregroundStyle(.blue)
                                    .opacity(0.3)
                            }
                        }
                    })
                    Rectangle()
                        .frame(width:500,height:3,alignment: .leading)
                }
            }
            .offset(x:-40)
            .padding()
            Rectangle()
                .frame(width: 3, height: 900)
                .offset(x: -57)
            StudentMachineView(student:$student, selectedMachine: $selectedMachine, shower: $shower)
        }
        .onAppear {
            for eachStudent in students{
                if name == eachStudent.name && Class == eachStudent.Class{
                    student = eachStudent
                    shower = 10
                }
            }
            if shower == -1{
                shower = 5
            }
            name = ""
            Class = ""
        }
        .frame(width: 540, height: 795)
        
    }
}
