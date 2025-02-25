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
    @State private var quizSubmitted: Bool = false
    @Environment(\.modelContext) var context
    @Query var stud:[StudentData] = []
    @FirestoreQuery(collectionPath: "Students") var students:[Student]
    @Binding var machines: [machineInfo]
    let quizzes: [String: [(String, [String], Int)]] = [
        "Mille": [
            ("1", ["a", "b", "correct", "d"], 2),
            ("2", ["a", "correct", "c", "d"], 1),
            ("3", ["a", "b", "c", "correct"], 3),
            ("4", ["correct", "b", "c", "d"], 0),
            ("5", ["correct", "b", "c", "d"], 0)
        ],
        "Angle Grinder": [
            ("1", ["correct", "b", "c", "d"], 0),
            ("2", ["a", "b", "c", "correct"], 3),
            ("3", ["a", "b", "c", "correct"], 3),
            ("4", ["a", "correct", "c", "d"], 1),
            ("5", ["correct", "b", "c", "d"], 0)
        ],
        "Lathe": [
            ("1", ["correct", "b", "b", "d"], 0),
            ("2", ["a", "b", "correct", "d"], 2),
            ("3", ["a", "b", "correct", "d"], 2),
            ("4", ["a", "correct", "c", "d"], 1),
            ("5", ["a", "b", "correct", "d"], 2)
        ],
        "Welder": [
            ("1", ["a", "b", "correct", "d"], 2),
            ("2", ["a", "b", "correct", "d"], 2),
            ("3", ["a", "correct", "c", "d"], 1),
            ("4", ["correct", "b", "c", "d"], 0),
            ("5", ["a", "b", "correct", "d"], 2)
        ]
    ]

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
        VStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                let questions: [(String, [String], Int)] = quizzes[selectedMachine] ?? []

                Text(questions[currentQuestionIndex].0)
                    .font(.title2)
                            .bold()
                            .padding(.bottom, 20)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .center)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                    ForEach(questions[currentQuestionIndex].1.indices, id: \.self) { optionIndex in
                        Button(action: {
                            if !quizSubmitted {
                                selectedAnswers[currentQuestionIndex] = optionIndex
                            }
                        }) {
                            HStack {
                                Circle()
                                    .fill(selectedAnswers[currentQuestionIndex] == optionIndex ? Color.blue : Color.gray)
                                    .frame(width: 20, height: 20)
                                Text(questions[currentQuestionIndex].1[optionIndex])
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray))
                        }
                        .disabled(quizSubmitted)
                    }
                }
            }
            
            HStack {
                if currentQuestionIndex > 0 && !quizSubmitted {
                    Button(action: {
                        currentQuestionIndex -= 1
                    }) {
                        Text("Previous")
                            .frame(width: 135, height: 50)
                            .background(.blue)
                            .foregroundStyle(.white)
                            .font(.title)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                
                Spacer()
                
                if currentQuestionIndex < questions.count - 1 && !quizSubmitted {
                    Button(action: {
                        currentQuestionIndex += 1
                    }) {
                        Text("Next")
                            .frame(width: 90, height: 50)
                            .background(.blue)
                            .foregroundStyle(.white)
                            .font(.title)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                } else {
                    Button(action: {
                        showResults = true
                        quizSubmitted = true
                        switch selectedMachine {
                        case "Mille": stud[0].MillTest = calculateScore()
                        case "Angle Grinder": stud[0].AngleGrinderTest = calculateScore()
                        case "Lathe": stud[0].LatheTest = calculateScore()
                        default: stud[0].WelderTest = calculateScore()
                        }
                        machineStatusUpdate()
                    }) {
                        Text("Submit")
                            .frame(width: 180, height: 60)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .font(.title2)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(radius: 8)
                    }
                    .disabled(quizSubmitted)
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
                        let selectedIndex = selectedAnswers[index]
                        let correctIndex = questions[index].2
                        HStack {
                            Spacer()
                            
                            if selectedIndex == correctIndex {
                                Text("Correct")
                                    .foregroundColor(.green)
                                    .bold()
                            } else {
                                Text("Incorrect")
                                    .foregroundColor(.red)
                                    .bold()
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
        }
    }

    func machineStatusUpdate() {
        machines = [machineInfo(name: "Mille", test: stud[0].MillTest, video: stud[0].MillVideo, videoID: "PKQPey6L42M"),
                    machineInfo(name: "Angle Grinder", test: stud[0].AngleGrinderTest, video: stud[0].AngleGrinderVideo, videoID: "PKQPey6L42M"),
                    machineInfo(name: "Lathe", test: stud[0].LatheTest, video: stud[0].LatheVideo, videoID: "PKQPey6L42M"),
                    machineInfo(name: "Welder", test: stud[0].WelderTest, video: stud[0].WelderVideo, videoID: "PKQPey6L42M")]
        
        let database = Firestore.firestore()
        database.collection("Students").document(stud[0].name).setData([
            "name": stud[0].name,
            "Teacher": stud[0].Teacher,
            "AngleGrinderTest": stud[0].AngleGrinderTest,
            "AngleGrinderVideo": stud[0].AngleGrinderVideo,
            "Class": stud[0].Class,
            "LatheTest": stud[0].LatheTest,
            "LatheVideo": stud[0].LatheVideo,
            "MillTest": stud[0].MillTest,
            "MillVideo": stud[0].MillVideo,
            "WelderTest": stud[0].WelderTest,
            "WelderVideo": stud[0].WelderVideo
        ])
    }
}
