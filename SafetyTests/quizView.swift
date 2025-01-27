//
//  quizView.swift
//  SafetyTests
//
//  Created by Eric M. Wetzel on 1/10/25.
//

import SwiftUI
import SwiftData

struct quizView: View {
    @State private var selectedAnswers: [Int?] = Array(repeating: nil, count: 5)
    @State private var currentQuestionIndex: Int = 0
    @State private var showResults: Bool = false
    @Environment(\.modelContext) var context
    @Query var student:[StudentData] = []

    let questions = [
        ("x", ["a", "b", "c", "d"],2),
        ("x", ["a", "b", "c", "d"],2),
        ("x", ["a", "b", "c", "d"],0),
        ("x", ["a", "b", "c", "d"],1),
        ("x", ["a", "b", "c", "d"],3)
    ]
//    student[0].AngleGrinderTest
    
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
            Text("Safety Quiz")
                .font(.title)
                .bold()

            VStack(alignment: .leading, spacing: 10) {
                Text(questions[currentQuestionIndex].0)
                    .font(.headline)

                ForEach(0..<questions[currentQuestionIndex].1.count, id: \.self) { optionIndex in
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
                    }) {
                        Text("Submit")
                            
                    }
                }
            }
            .padding(.top)

            if showResults {
                Text("Results: \(selectedAnswers.compactMap { $0 }).count correct answers")
                    .padding()
                    .font(.title2)
                Button(action: {
                    let score = calculateScore()
                    
                
//                    context.save(student[0].AngleGrinderTest = score)
                }) {
                    Text("Save Results")
                }

            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        quizView()
    }
}
