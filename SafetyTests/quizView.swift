//
//  quizView.swift
//  SafetyTests
//
//  Created by Eric M. Wetzel on 1/10/25.
//

import SwiftUI

struct quizView: View {
    @State private var selectedAnswers: [Int?] = Array(repeating: nil, count: 5)
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
            ForEach(0..<questions.count, id: \.self) { index in
                VStack(alignment: .leading, spacing: 10) {
                    Text(questions[index].0)
                        .font(.headline)

                    ForEach(0..<questions[index].1.count, id: \.self) { optionIndex in
                        Button(action: {
                            selectedAnswers[index] = optionIndex
                        }) {
                            HStack {
                                Circle()
                                    .fill(selectedAnswers[index] == optionIndex ? Color.blue : Color.gray)
                                    .frame(width: 20, height: 20)
                                Text(questions[index].1[optionIndex])
                            }
                        }
                    }
                }
                
            }

            Button(action: {
                showResults = true
            }) {
                Text("Submit")
            }
            
        }
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        quizView()
    }
}
