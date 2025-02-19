//
//  quizView.swift
//  SafetyTests
//
//  Created by Eric M. Wetzel on 1/10/25.
//

import SwiftUI
import SwiftData
import Firebase
import FirebaseFirestore

struct quizView: View {
    @State private var selectedAnswers: [Int?] = Array(repeating: nil, count: 5)
    @State private var currentQuestionIndex: Int = 0
    @State private var showResults: Bool = false
    @Environment(\.modelContext) var context
    @Query var stud:[StudentData] = []
    @FirestoreQuery(collectionPath: "Students") var students:[Student]
    @Binding var machines: [machineInfo]
    let quizzes: [String: [(String, [String], Int)]] = [
        "Mille": [
            ("x", ["a", "b", "correct", "d"], 2),
            ("x", ["a", "correct", "c", "d"], 1),
            ("x", ["a", "b", "c", "correct"], 3),
            ("x", ["correct", "b", "c", "d"], 0),
            ("x", ["correct", "b", "c", "d"], 0)
        ],
        "Angle Grinder": [
            ("x", ["correct", "b", "c", "d"], 0),
            ("x", ["a", "b", "c", "correct"], 3),
            ("x", ["a", "b", "c", "correct"], 3),
            ("x", ["a", "correct", "c", "d"], 1),
            ("x", ["correct", "b", "c", "d"], 0)
        ],
        "Lathe": [
            ("x", ["correct", "b", "b", "d"], 0),
            ("x", ["a", "b", "correct", "d"], 2),
            ("x", ["a", "b", "correct", "d"], 2),
            ("x", ["a", "correct", "c", "d"], 1),
            ("x", ["a", "b", "correct", "d"], 2)
        ],
        "Welder": [
            ("x", ["a", "b", "correct", "d"], 2),
            ("x", ["a", "b", "correct", "d"], 2),
            ("x", ["a", "correct", "c", "d"], 1),
            ("x", ["correct", "b", "c", "d"], 0),
            ("x", ["a", "b", "correct", "d"], 2)
        ]
    ]

    //    student[0].AngleGrinderTest
    
    @Binding var selectedMachine: String
    var questions: [(String, [String], Int)] {
            quizzes[selectedMachine] ?? []
        }
    
    func calculateScore() -> Int {
        var score = 0
        
        for (index, answer) in selectedAnswers.enumerated() {
            if let selectedIndex = answer, selectedIndex == questions[index].2 {
                score += 1
            }
        }
        
        return score
    }
    
    var body: some View {
        VStack(spacing: 15) {
//            Text("Safety Quiz")
          
//                .font(.title)
//                .bold()
            
            VStack(alignment: .leading, spacing: 10) {
                let questions: [(String, [String], Int)] = quizzes[selectedMachine] ?? []

                
                ForEach(questions[currentQuestionIndex].1.indices, id: \.self) { optionIndex in

                    Button(action: {
                        selectedAnswers[currentQuestionIndex] = optionIndex
                    }) {
                        HStack {
                            Circle()
                                .fill(selectedAnswers[currentQuestionIndex] == optionIndex ? Color.blue : Color.gray)
                                .frame(width: 20, height: 20)
                            Text(questions[currentQuestionIndex].1[optionIndex])
                        }
                    }
                }
            }
            
            HStack {
                if currentQuestionIndex > 0 {
                    Button(action: {
                        currentQuestionIndex -= 1
                    }) {
                        Text("Previous")
                        
                    }
                }
                
                Spacer()
                
                if currentQuestionIndex < questions.count - 1 {
                    Button(action: {
                        currentQuestionIndex += 1
                    }) {
                        Text("Next")
                        
                    }
                } else {
                    Button(action: {
                        showResults = true
                        switch selectedMachine{
                        case "Mille":stud[0].MillTest = calculateScore()
                        case "Angle Grinder":stud[0].AngleGrinderTest = calculateScore()
                        case "Lathe": stud[0].LatheTest = calculateScore()
                        default: stud[0].WelderTest = calculateScore()
                        }
                        machineStatusUpdate()
                    }) {
                        Text("Submit")
                        
                    }
                }
            }
            .padding(.top)
            
            if showResults {
                let score = calculateScore()
                VStack {
                    Text("You scored \(score) out of \(questions.count)")
                        .font(.title2)
                        .padding()
                    
                    
                    ForEach(0..<questions.count, id: \.self) { index in
                        HStack {
                            Text("Q\(index + 1): \(questions[index].0)")
                                .font(.headline)
                            
                            Spacer()
                            
                            if let selectedIndex = selectedAnswers[index] {
                                Text("Your Answer: \(questions[index].1[selectedIndex])")
                                    .foregroundColor(selectedIndex == questions[index].2 ? .green : .red)
                            }
                            
                            Text("Correct Answer: \(questions[index].1[questions[index].2])")
                                .foregroundColor(.blue)
                        }
                        .padding(.vertical)
                    }
                }
            }
        }
    }
    
    func machineStatusUpdate(){
        machines = [machineInfo(name: "Mille", test: stud[0].MillTest, video: stud[0].MillVideo, videoID: "PKQPey6L42M"),machineInfo(name: "Angle Grinder", test: stud[0].AngleGrinderTest, video: stud[0].AngleGrinderVideo, videoID: "PKQPey6L42M"),machineInfo(name: "Lathe", test: stud[0].LatheTest, video: stud[0].LatheVideo, videoID: "PKQPey6L42M"),machineInfo(name: "Welder", test: stud[0].WelderTest, video: stud[0].WelderVideo, videoID: "PKQPey6L42M")]
        let database = Firestore.firestore()
        database.collection("Students").document(stud[0].name).setData(["name":stud[0].name,"Teacher":stud[0].Teacher,"AngleGrinderTest":stud[0].AngleGrinderTest,"AngleGrinderVideo":stud[0].AngleGrinderVideo,"Class":stud[0].Class,"LatheTest":stud[0].LatheTest,"LatheVideo":stud[0].LatheVideo,"MillTest":stud[0].MillTest,"MillVideo":stud[0].MillVideo,"WelderTest":stud[0].WelderTest,"WelderVideo":stud[0].WelderVideo])
    }

}
