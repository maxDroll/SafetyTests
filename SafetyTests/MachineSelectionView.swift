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
    let machines = ["Lathe", "Mill", "Welder", "Angle Grinder"]
    @AppStorage("name") var name = ""
    @AppStorage("class") var Class = ""
    @State private var selectedMachine: String = ""
    @FirestoreQuery(collectionPath: "Students") var students:[Student]
    @State var student: Student = Student(AngleGrinderTest: -1, AngleGrinderVideo: false, Class: "Till", LatheTest: -1, LatheVideo: false, MillTest: -1, MillVideo: false, WelderTest: -1, WelderVideo: false, name: "Bill", Teacher: false, StudentID: "somethin")
    var body: some View {
        NavigationStack {
            if let screenSize = UIScreen.main.bounds as CGRect? {
                HStack(spacing:0){
                    VStack(spacing:0){
//                        Rectangle()
//                            .frame(width: (screenSize.width * (5 / 12)),height:3,alignment: .leading)
                        ForEach(machines, id: \.self) { machine in
                            Button(action: {
                                selectedMachine = machine
                                for StudentTemp in students{
                                    if name == StudentTemp.name && Class == StudentTemp.Class{
                                        student = StudentTemp
                                    }
                                }
                            },label:  {
                                ZStack{
                                    Text(machine)
                                        .foregroundStyle(.black)
                                        .frame(width:(screenSize.width * (5 / 12)) - 40,height:208,alignment: .leading)
                                        .font(.system(size: 50))
                                    if selectedMachine == machine{
                                        Rectangle()
                                            .frame(width: (screenSize.width * (5 / 12)) + 17, height: 208)
                                            .foregroundStyle(.blue)
                                            .opacity(0.3)
                                    }
                                }
                            })
                            Rectangle()
                                .frame(width:(screenSize.width * (5 / 12)) + 17,height:3,alignment: .leading)
                        }
                    }
                    .offset(x:-40)
                    .padding()
                    Rectangle()
                        .frame(width: 3, height: 9000)
                        .offset(x: -57)
                    StudentMachineView(selectedMachine: $selectedMachine)
                }
                .frame(width: (screenSize.width * (5 / 12)) + 40, height: 795)
                
            }
        }
    }
}
