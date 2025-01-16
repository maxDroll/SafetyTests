//
//  StudentViewModel.swift
//  SafetyTests
//
//  Created by Maxwell K. Droll on 12/11/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class StudentMachineBrain: ObservableObject{
    @FirestoreQuery(collectionPath: "Students") var students:[Student]
    @AppStorage("name") var name = ""
    @AppStorage("class") var Class = ""
    @Published var student: Student = Student(AngleGrinderTest: 100, AngleGrinderVideo: false, Class: "Billy", LatheTest: -1, LatheVideo: true, MillTest: -1, MillVideo: false, WelderTest: -1, WelderVideo: false, name: "Tilly", Teacher: false)
    init() {
        @FirestoreQuery(collectionPath: "Students") var students:[Student]
        @AppStorage("name") var name = ""
        @AppStorage("class") var Class = ""
        settingStudent()
    }
    func settingStudent(){
        
            for eachStudent in students{
                if eachStudent.name == name && eachStudent.Class == Class{
                    student = eachStudent
                }
            }
        print(students.count)
            student = Student(AngleGrinderTest: 100, AngleGrinderVideo: false, Class: "Billy", LatheTest: -1, LatheVideo: true, MillTest: -1, MillVideo: false, WelderTest: -1, WelderVideo: false, name: "Tilly", Teacher: false)
    }
}

