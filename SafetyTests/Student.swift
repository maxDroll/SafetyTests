//
//  Student.swift
//  SafetyTests
//
//  Created by Maxwell K. Droll on 12/11/24.
//

import SwiftUI

struct Student:Decodable{
    var AngleGrinderTest = -1
    var AngleGrinderVideo = false
    let Class: String
    var LatheTest = -1
    var LatheVideo = false
    var MillTest = -1
    var MillVideo = false
    var WelderTest = -1
    var WelderVideo = false
    let name: String
    let Teacher = false
}
