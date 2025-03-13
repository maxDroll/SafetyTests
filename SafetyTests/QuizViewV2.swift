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
    @State var questions: [questionsStruct] = [questionsStruct(Quests: ["Lathe1","Lathe2","Lathe3","Lathe4","Lathe5"], correctAnswers: [0,3,2,4,1], answersVar: [answer(answer14:["A1","B1","C1","D1"]),answer(answer14:["A2","B2","C2","D2"]),answer(answer14:["A3","B3","C3","D3"]),answer(answer14:["A4","B4","C4","D4"]),answer(answer14:["A5","B5","C5","D5"])], machine: "Lathe"),questionsStruct(Quests: ["Mill1","Mill2","Mill3","Mill4","Mill5"], correctAnswers: [0,3,2,4,1], answersVar: [answer(answer14:["A1","B1","C1","D1"]),answer(answer14:["A2","B2","C2","D2"]),answer(answer14:["A3","B3","C3","D3"]),answer(answer14:["A4","B4","C4","D4"]),answer(answer14:["A5","B5","C5","D5"])], machine: "Mill"),questionsStruct(Quests: ["AngleGrinder1","AngleGrinder2","AngleGrinder3","AngleGrinder4","AngleGrinder5"], correctAnswers: [0,3,2,4,1], answersVar: [answer(answer14:["A1","B1","C1","D1"]),answer(answer14:["A2","B2","C2","D2"]),answer(answer14:["A3","B3","C3","D3"]),answer(answer14:["A4","B4","C4","D4"]),answer(answer14:["A5","B5","C5","D5"])], machine: "Angle Grinder"),questionsStruct(Quests: ["Welder1","Welder2","Welder3","Welder4","Welder5"], correctAnswers: [0,3,2,4,1], answersVar: [answer(answer14:["A1","B1","C1","D1"]),answer(answer14:["A2","B2","C2","D2"]),answer(answer14:["A3","B3","C3","D3"]),answer(answer14:["A4","B4","C4","D4"]),answer(answer14:["A5","B5","C5","D5"])], machine: "Welder")]
    var body: some View {
        if submitted{
            
        } else{
            QuestionsView(answers: $answers, questions: questions, submitted: $submitted, selectedMachine: selectedMachine)
        }
    }
    struct QuestionsView: View {
        @Binding var answers:[Int]
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
                                ZStack{
                                    if answers[questionNumber] == 0{
                                        Rectangle()
                                            .frame(width: 400, height: 100)
                                            .foregroundStyle(.blue)
                                            .opacity(0.3)
                                    }
                                    Button {
                                        answers[questionNumber] = 0
                                    } label: {
                                        Text("  " + machine.answersVar[questionNumber].answer14[0])
                                            .font(.title)
                                            .frame(width: 400, height: 100, alignment: .leading)
                                            .border(Color.black, width: 3)
                                            .foregroundStyle(.black)
                                    }
                                }
                                ZStack{
                                    if answers[questionNumber] == 2{
                                        Rectangle()
                                            .frame(width: 400, height: 100)
                                            .foregroundStyle(.blue)
                                            .opacity(0.3)
                                    }
                                    Button {
                                        answers[questionNumber] = 2
                                    } label: {
                                        Text("  " + machine.answersVar[questionNumber].answer14[2])
                                            .font(.title)
                                            .frame(width: 400, height: 100, alignment: .leading)
                                            .border(Color.black, width: 3)
                                            .foregroundStyle(.black)
                                    }
                                }
                            }
                            VStack{
                                ZStack{
                                    if answers[questionNumber] == 1{
                                        Rectangle()
                                            .frame(width: 400, height: 100)
                                            .foregroundStyle(.blue)
                                            .opacity(0.3)
                                    }
                                    Button {
                                        answers[questionNumber] = 1
                                    } label: {
                                        Text("  " + machine.answersVar[questionNumber].answer14[1])
                                            .font(.title)
                                            .frame(width: 400, height: 100, alignment: .leading)
                                            .border(Color.black, width: 3)
                                            .foregroundStyle(.black)
                                    }
                                }
                                ZStack{
                                    if answers[questionNumber] == 3{
                                        Rectangle()
                                            .frame(width: 400, height: 100)
                                            .foregroundStyle(.blue)
                                            .opacity(0.3)
                                    }
                                    Button {
                                        answers[questionNumber] = 3
                                    } label: {
                                        Text("  " + machine.answersVar[questionNumber].answer14[3])
                                            .font(.title)
                                            .frame(width: 400, height: 100, alignment: .leading)
                                            .border(Color.black, width: 3)
                                            .foregroundStyle(.black)
                                    }
                                }
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
                    }
                }
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
