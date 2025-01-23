//
//  StudentViewModel.swift
//  SafetyTests
//
//  Created by Maxwell K. Droll on 12/11/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

//class StudentMachineBrain: ObservableObject{
//    @Published var stud: StudentData
//    @Published var machines: [machineInfo] = []
//    @Published var selectedMachine = ""
//    
//    
//    
//    func machineStatusUpdate(){
//        machines = [machineInfo(name: "Mille", test: stud.MillTest, video: stud.MillVideo),machineInfo(name: "Angle Grinder", test: stud.AngleGrinderTest, video: stud.AngleGrinderVideo),machineInfo(name: "Lathe", test: stud.LatheTest, video: stud.LatheVideo),machineInfo(name: "Welder", test: stud.WelderTest, video: stud.WelderVideo)]
//        let database = Firestore.firestore()
//        database.collection("Students").document(stud.name).setData(["name":stud.name,"Teacher":stud.Teacher,"AngleGrinderTest":stud.AngleGrinderTest,"AngleGrinderVideo":stud.AngleGrinderVideo,"Class":stud.Class,"LatheTest":stud.LatheTest,"LatheVideo":stud.LatheVideo,"MillTest":stud.MillTest,"MillVideo":stud.MillVideo,"WelderTest":stud.WelderTest,"WelderVideo":stud.WelderVideo])
//    }
//    
//    func updateVideoStatus(){
//        switch selectedMachine{
//        case "Mille":stud.MillVideo.toggle()
//        case "Angle Grinder":stud.AngleGrinderVideo.toggle()
//        case "Lathe": stud.LatheVideo.toggle()
//        default: stud.WelderVideo.toggle()
//        }
//        machineStatusUpdate()
//    }
//}

