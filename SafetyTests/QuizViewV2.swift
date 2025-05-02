//
//  QuizViewV2.swift
//  SafetyTests
//
//  Created by Maxwell K. Droll on 2/25/25.
//

import SwiftUI
import SwiftData
import Firebase
import FirebaseFirestore


struct quizViewV2: View {
    @State var submitted = false
    @Binding var selectedMachine:String
    @State var questionNumber = 0
    @State var answers: [Int] = [-1,-1,-1,-1,-1]
    @State var machine = -1
    @State var questions: [questionsStruct] = [questionsStruct(Quests: ["Lathe1","Lathe2","Lathe3","Lathe4","Lathe5"], correctAnswers: [0,3,2,3,1], answersVar: [answer(answer14:["A1","B1","C1","D1"]),answer(answer14:["A2","B2","C2","D2"]),answer(answer14:["A3","B3","C3","D3"]),answer(answer14:["A4","B4","C4","D4"]),answer(answer14:["A5","B5","C5","D5"])], machine: "Lathe"),questionsStruct(Quests: ["Mill1","Mill2","Mill3","Mill4","Mill5"], correctAnswers: [0,3,2,3,1], answersVar: [answer(answer14:["A1","B1","C1","D1"]),answer(answer14:["A2","B2","C2","D2"]),answer(answer14:["A3","B3","C3","D3"]),answer(answer14:["A4","B4","C4","D4"]),answer(answer14:["A5","B5","C5","D5"])], machine: "Mill"),questionsStruct(Quests: ["AngleGrinder1","AngleGrinder2","AngleGrinder3","AngleGrinder4","AngleGrinder5"], correctAnswers: [0,3,2,3,1], answersVar: [answer(answer14:["A1","B1","C1","D1"]),answer(answer14:["A2","B2","C2","D2"]),answer(answer14:["A3","B3","C3","D3"]),answer(answer14:["A4","B4","C4","D4"]),answer(answer14:["A5","B5","C5","D5"])], machine: "Angle Grinder"),questionsStruct(Quests: ["Welder1","Welder2","Welder3","Welder4","Welder5"], correctAnswers: [0,3,2,3,1], answersVar: [answer(answer14:["A1","B1","C1","D1"]),answer(answer14:["A2","B2","C2","D2"]),answer(answer14:["A3","B3","C3","D3"]),answer(answer14:["A4","B4","C4","D4"]),answer(answer14:["A5","B5","C5","D5"])], machine: "Welder")]
    var body: some View {
        if submitted{
            Text("You Got a \(countRight())/5")
            ForEach(0...4, id:\.self){number in
                if answers[number] == questions[machine].correctAnswers[number]{
                    Text("\(number): correct")
                        .font(.title)
                }else{
                    Text("\(number): incorrect")
                        .font(.title)
                }
            }
            ForEach(0...10, id:\.self){ number in
                Text("Safety test garbage")
            }
        } else{
            QuestionsView(answers: $answers, machine: $machine, questions: questions, submitted: $submitted, selectedMachine: selectedMachine)
        }
    }
    func countRight() -> Int{
        var counter = 0
        for i in 0...4{
            if answers[i] == questions[machine].correctAnswers[i]{
                counter += 1
            }
        }
        return counter
    }
    struct QuestionsView: View {
        @Binding var answers:[Int]
        @Binding var machine: Int
        let questions: [questionsStruct]
        @State var questionNumber = 0
        @Binding var submitted: Bool
        let selectedMachine: String
        var body: some View {
            VStack{
                ForEach(questions, id:\.self){ machine in
                    if machine.machine == selectedMachine{
                        Text(machine.Quests[questionNumber])
                            .font(.largeTitle)
                        HStack{
                            VStack{
                                IndividualAnswer(answers: $answers, machine: machine, questionNumber: questionNumber, questionOption: 0, submitted: submitted)
                                IndividualAnswer(answers: $answers, machine: machine, questionNumber: questionNumber, questionOption: 2, submitted: submitted)
                            }
                            VStack{
                                IndividualAnswer(answers: $answers, machine: machine, questionNumber: questionNumber, questionOption: 1, submitted: submitted)
                                IndividualAnswer(answers: $answers, machine: machine, questionNumber: questionNumber, questionOption: 3, submitted: submitted)
                            }
                        }
                    }
                }
                Button("next"){
                    if questionNumber < 4{
                        questionNumber += 1
                    }
                }
                Button("back"){
                    if questionNumber > 0{
                        questionNumber -= 1
                    }
                }
                if questionNumber == 4{
                    Button("submit"){
                        submitted = true
                        switch selectedMachine{
                        case "Lathe": machine = 0
                        case "Mill": machine = 1
                        case "Angle Grinder": machine = 2
                        default: machine = 3
                        }
                    }
                }
            }
        }
    }
    struct IndividualAnswer: View {
        @Binding var answers:[Int]
        let machine: questionsStruct
        var questionNumber: Int
        let questionOption: Int
        let submitted: Bool
        var body: some View {
            ZStack{
                if answers[questionNumber] == questionOption{
                    Rectangle()
                        .frame(width: 400, height: 100)
                        .foregroundStyle(.blue)
                        .opacity(0.3)
                }
                Button {
                    answers[questionNumber] = questionOption
                } label: {
                    Text("  " + machine.answersVar[questionNumber].answer14[questionOption])
                        .font(.title)
                        .frame(width: 400, height: 100, alignment: .leading)
                        .border(Color.black, width: 3)
                        .foregroundStyle(.black)
                }
                .disabled(submitted)
            }
        }
    }
    struct questionsStruct: Hashable{
        var Quests: [String]
        var correctAnswers: [Int]
        var answersVar: [answer]
        var machine: String
    }
    struct answer: Hashable{
        var answer14: [String]
    }
}
