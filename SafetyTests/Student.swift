//
//  Student.swift
//  SafetyTests
//
//  Created by Maxwell K. Droll on 12/11/24.
//

import SwiftUI
import SwiftData


struct Student: Decodable{
    var AngleGrinderTest: Int
    var AngleGrinderVideo: Bool
    var Class: String
    var LatheTest: Int
    var LatheVideo: Bool
    var MillTest: Int
    var MillVideo: Bool
    var WelderTest: Int
    var WelderVideo: Bool
    var name: String
    var Teacher: Bool
}



@Model

class StudentData{
    var AngleGrinderTest: Int
    var AngleGrinderVideo: Bool
    var Class: String
    var LatheTest: Int
    var LatheVideo: Bool
    var MillTest: Int
    var MillVideo: Bool
    var WelderTest: Int
    var WelderVideo: Bool
    var name: String
    var Teacher: Bool
    
    init(AngleGrinderTest: Int, AngleGrinderVideo: Bool, Class: String, LatheTest: Int, LatheVideo: Bool, MillTest: Int, MillVideo: Bool, WelderTest: Int, WelderVideo: Bool, name: String, Teacher: Bool){
        self.AngleGrinderTest = AngleGrinderTest
        self.AngleGrinderVideo = AngleGrinderVideo
        self.Class = Class
        self.LatheTest = LatheTest
        self.LatheVideo = LatheVideo
        self.MillTest = MillTest
        self.MillVideo = MillVideo
        self.WelderTest = WelderTest
        self.WelderVideo = WelderVideo
        self.name = name
        self.Teacher = Teacher
    }
}
