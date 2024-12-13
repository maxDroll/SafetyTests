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
        HStack{
            VStack(spacing:100) {
                ForEach(machines, id: \.self) { machine in
                    Button(action: {
                        selectedMachine = machine
                    }) {
                        ZStack{
                            Text(machine)
                                .foregroundStyle(.black)
                                .frame(width:300,alignment: .leading)
                                .font(.system(size: 50))
                            if selectedMachine == machine{
                                Rectangle()
                                    .frame(width: 300, height: 100)
                                    .foregroundStyle(.blue)
                                    .opacity(0.3)
                            }
                        }
                    }
                }
            }
            .padding()
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
        
    }
}
