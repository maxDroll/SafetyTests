//
//  quizView.swift
//  SafetyTests
//
//  Created by Eric M. Wetzel on 1/10/25.
//

import SwiftUI

struct quizView: View {
    @State private var selectedAnswers: [Int?] = Array(repeating: nil, count: 5)
    @State private var currentQuestionIndex: Int = 0
    @State private var showResults: Bool = false

    let questions = [
        ("x", ["a", "b", "c", "d"]),
        ("x", ["a", "b", "c", "d"]),
        ("x", ["a", "b", "c", "d"]),
        ("x", ["a", "b", "c", "d"]),
        ("x", ["a", "b", "c", "d"])
    ]

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

//            if showResults {
//                Text("Results: \(selectedAnswers.compactMap { $0 }).count correct answers")
//                    .padding()
//                    .font(.title2)
//            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        quizView()
    }
}
