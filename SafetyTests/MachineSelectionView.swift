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
    let machines = ["Lathe ", "Mille", "Welder", "Angle Grinder"]
    @AppStorage("name") var name = ""
    @AppStorage("class") var Class = ""
    @State private var selectedMachine: String = ""
    @FirestoreQuery(collectionPath: "Students") var students:[Student]
    @State var student: Student = Student(Class: "Bill", name: "till")
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
            StudentMachineView(student:$student, selectedMachine: $selectedMachine)
        }
        .onAppear {
            for eachStudent in students{
                if name == eachStudent.name && Class == eachStudent.Class{
                    student = eachStudent
                }
            }
//            name = ""
//            Class = ""
        }
        .frame(width: 540, height: 795)
        
    }
}
