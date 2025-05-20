import SwiftUI
import SwiftData
import Firebase
import FirebaseFirestore

struct quizView: View {
    @State private var selectedAnswers: [Int] = Array(repeating: -1, count: 14)
    @State private var currentQuestionIndex: Int = 0
    @State private var showResults: Bool = false
    @State private var quizSubmitted: Bool = false
    @Environment(\.modelContext) var context
    @Query var stud: [StudentData] = []
    @FirestoreQuery(collectionPath: "Students") var students: [Student]
    @Binding var machines: [machineInfo]
    @Binding var selectedMachine: String

    let quizzes: [String: [(String, [String], Int)]] = [
        "Mill": [
            ("When operating the vertical mill or any machine, you should always wear _________. Even when the machine is in the OFF state.", ["Long Pants", "Safety Glasses", "Gloves", "N/A"], 1),
            ("Never allow _______ or _________ near an operating milling machine.", ["Necklaces or hair", "Coolant or oil", "Cutting tools or drills", "N/A"], 0),
            ("Metal chips should always be cleared off the machine using _______.", ["A Brush", "Air Pressure", "Latex Gloves", "No Gloves"], 0),
            ("Always remove and return drawbar wrench after changing tools.", ["True", "False", "N/A", "N/A"], 0),
            ("Make sure you firmly tighten the stock in the _________ before milling.", ["Quill", "Table", "Milling Vise", "Draw Bar"], 2),
            ("Never reach over or near a revolving cutting tool. Keeps hands at least _________ away from revolving cutting tool.", ["3 inches", "6 inches", "12 inches", "N/A"], 2),
            ("The tool holding device that safely & evenly holds endmills is called a _________.", ["Drill Chuck", "Quill", "Draw Bar", "R8 Collet"], 3),
            ("You can safely use an endmill in a Drill Chuck", ["True", "False", "N/A", "N/A"], 1),
            ("Do not move the operating levers without knowing what they control and what action is going to take place.", ["True", "False", "N/A", "N/A"], 0),
            ("Always be sure the cutting tool is spinning in the ___________ direction", ["Counter Clockwise", "Clockwise", "N/A", "N/A"], 1),
            ("Do not take an excessively heavy cut or feed as it can cause the cutter to break. The flying pieces could cause serious injury.", ["True", "False", "N/A", "N/A"], 0),
            ("Always measure your part or check your cut finish when the machine is ________________.", ["ON", "IDLE/Neutral", "OFF", "N/A"], 2)
        ],
        "Lathe": [
            ("When operating the CNC Lathe or any machine, you should always wear _________. Even when the machine is in the OFF state.", ["Long Pants", "Safety Glasses", "Gloves", "N/A"], 1),
            ("Never allow _______ or _________ near an operating milling machine.", ["Necklaces or hair", "Coolant or oil", "Cutting tools or drills", "N/A"], 0),
            ("Never put your hand or arm inside the parts catcher chute.", ["True", "False", "N/A", "N/A"], 0),
            ("Metal chips should always be cleared off the machine using _______ and appropriate gloves to remove processed material and to clean the machine.", ["A Brush", "Air Pressure", "Latex Gloves", "No Gloves"], 0),
            ("Always remove and return check tightening key after loading materials.", ["True", "False", "N/A", "N/A"], 0),
            ("Make sure you firmly tighten the stock in the _________ before milling.", ["Quill", "Table", "Center Chuck", "Draw Bar"], 2),
            ("Never reach over or near a revolving cutting tool. Keeps hands at least _________ away from revolving cutting tool.", ["3 inches", "6 inches", "12 inches", "N/A"], 2),
            ("When loading stock, make sure that ________ jaws are holding the stock to avoid the stock coming loose", ["1", "2", "3", "All"], 3),
            ("Do not operate the machine unless the doors are closed and the door interlocks are functioning correctly.", ["True", "False", "N/A", "N/A"], 0),
            ("Do not move the operating levers, push buttons or make adjustment without knowing what they control and what action is going to take place.", ["True", "False", "N/A", "N/A"], 0),
            ("Always be sure the cutting tool is properly seated into the tool holder.", ["True", "False", "N/A", "N/A"], 0),
            ("Always measure your part or check your cut finish when the machine is", ["ON", "IDLE/Neutral", "OFF", "N/A"], 2)
        ],
        "Welder": [
            ("When operating the welder, you should always wear _________. Even when the machine is in the OFF state.", ["Long Sleeves", "Welding Helmet", "Gloves", "All of the above"], 3),
            ("Never allow _______ or _________ near an operating welding machine.", ["Necklaces or hair", "Welding wire", "Shielding gas", "N/A"], 0),
            ("Use effective ventilation whenever possible.", ["True", "False", "N/A", "N/A"], 0),
            ("Be sure that flammable products are stored near the work areas.", ["True", "False", "N/A", "N/A"], 1),
            ("Do not change the weld settings without knowing what they control and what action is going to take place.", ["True", "False", "N/A", "N/A"], 0),
            ("The exposure to UV light may result in damage to the ________ and _________.", ["Glass and wood", "Eyes and skin", "Welding machine and material", "N/A"], 1),
            ("Check to make sure an auto-darkening welding mask is operational ___________", ["Every time you use it", "Once a week", "Once a year", "Never"], 0),
            ("Wear clothing made from heavyweight, tightly woven, 100% wool or cotton (welding jackets) to protect from UV radiation, hot metal, sparks and open flames.", ["True", "False", "N/A", "N/A"], 0),
            ("Make sure that there is an appropriate _______ extinguisher or fire watch personnel close by, in case there is a fire.", ["Water", "Wood", "Fire", "Situation"], 2),
            ("Protect your face from _______  by wearing a tight-fitting, opaque welder's helmet.", ["Water splashing", "UV radiation", "Exhaust fumes", "N/A"], 1),
            ("It is ok to operate a welder with out proper PPE such as a welding mask, gloves, long sleeves, pants, closed toe shoes, etc.", ["True", "False", "N/A", "N/A"], 1),
            ("Shielding gas tanks need to be firmly secured to the welding cart.", ["True", "False", "N/A", "N/A"], 0),
            ("If the machine has a malfunction, such as stuck welding wire, turn the machine off, close the gas valve and get your instructor.", ["True","False","N/A","N/A"],0),
            ("It is ok to make a quick tack weld without any Personal Protective Equipment such as a welding mask, gloves, long selves, etc.",["True","False","N/A","N/A"],1)
        ]
    ]

    var questions: [(String, [String], Int)] {
        quizzes[selectedMachine] ?? []
    }

    func calculateScore() -> Int {
        var score = 0
        for index in 0..<questions.count {
            if selectedAnswers[index] == questions[index].2 {
                score += 1
            }
        }
        return score
//        selectedAnswers.enumerated().reduce(0) { result, item in
//            let (index, answer) = item
//            return result + ((answer == questions[index].2) ? 1 : 0)
//        }
    }

    var body: some View {
        GeometryReader { geometry in
            let isWide = geometry.size.width > 700
            
            ZStack {
                Color(.systemGray5).ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 30) {
                        Spacer(minLength: 30)

                        Text("Question \(currentQuestionIndex + 1) of \(questions.count)")
                            .font(.headline)
                            .foregroundColor(.secondary)

                        Text(questions[currentQuestionIndex].0)
                            .font(.largeTitle.bold())
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        LazyVGrid(
                            columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: isWide ? 2 : 1),
                            spacing: 20
                        ) {
                            ForEach(questions[currentQuestionIndex].1.indices, id: \.self) { optionIndex in
                                Button(action: {
                                    if !quizSubmitted {
                                        withAnimation {
                                            selectedAnswers[currentQuestionIndex] = optionIndex
                                        }
                                    }
                                }) {
                                    HStack(spacing: 12) {
                                        Circle()
                                            .fill(selectedAnswers[currentQuestionIndex] == optionIndex ? Color.blue : Color.gray)
                                            .frame(width: 20, height: 20)

                                        Text(questions[currentQuestionIndex].1[optionIndex])
                                            .foregroundColor(.black)
                                            .font(.title3)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(12)
                                    .shadow(color: .gray.opacity(0.3), radius: 5)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(selectedAnswers[currentQuestionIndex] == optionIndex ? Color.blue : Color.gray, lineWidth: 2)
                                    )
                                }
                                .padding(.horizontal, isWide ? 0 : 10)
                            }
                        }
                        .padding(.horizontal, 20)

                        // Navigation buttons
                        HStack(spacing: 20) {
                            if currentQuestionIndex > 0 && !quizSubmitted {
                                Button("Previous") {
                                    withAnimation { currentQuestionIndex -= 1 }
                                }
                                .quizButtonStyle(width: 135)
                            }

                            Spacer()

                            if currentQuestionIndex < questions.count - 1 && !quizSubmitted {
                                Button("Next") {
                                    withAnimation { currentQuestionIndex += 1 }
                                }
                                .quizButtonStyle(width: 90)
                            } else {
                                if !quizSubmitted {
                                    Button("Submit") {
                                        showResults = true
                                        quizSubmitted = true
                                        switch selectedMachine {
                                        case "Mill": stud[0].MillTest = calculateScore()
                                        case "Angle Grinder": stud[0].AngleGrinderTest = calculateScore()
                                        case "Lathe": stud[0].LatheTest = calculateScore()
                                        default: stud[0].WelderTest = calculateScore()
                                        }
                                        machineStatusUpdate()
                                    }
                                    .quizButtonStyle()
                                } else {
                                    NavigationLink(destination: MachineSelectionView().navigationBarBackButtonHidden(true)) {
                                        Text("Return")
                                            .quizButtonStyle()
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 30)

                        // Results View
                        if showResults {
                            VStack(spacing: 15) {
                                Text("You scored \(calculateScore()) out of \(questions.count)")
                                    .font(.title2.bold())
                                    .padding(.top)

                                ForEach(0..<questions.count, id: \.self) { index in
                                    let selectedIndex = selectedAnswers[index]
                                    let correctIndex = questions[index].2

                                    HStack {
                                        Text("Q\(index + 1): " + questions[index].0)
                                        Spacer()
                                        if selectedIndex == correctIndex {
                                            Label("Correct", systemImage: "checkmark.circle")
                                                .foregroundColor(.green)
                                        } else {
                                            Label("Incorrect", systemImage: "xmark.circle")
                                                .foregroundColor(.red)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                            .padding(.horizontal)
                        }

                        Spacer(minLength: 50)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .frame(minHeight: geometry.size.height) // Make sure it fills height even with little content
                }
            }
        }
    }


    func machineStatusUpdate() {
        machines = [
            machineInfo(name: "Mill", test: stud[0].MillTest, video: stud[0].MillVideo, videoID: "PKQPey6L42M"),
            machineInfo(name: "Angle Grinder", test: stud[0].AngleGrinderTest, video: stud[0].AngleGrinderVideo, videoID: "PKQPey6L42M"),
            machineInfo(name: "Lathe", test: stud[0].LatheTest, video: stud[0].LatheVideo, videoID: "PKQPey6L42M"),
            machineInfo(name: "Welder", test: stud[0].WelderTest, video: stud[0].WelderVideo, videoID: "PKQPey6L42M")
        ]

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

extension View {
    func quizButtonStyle(width: CGFloat = 180, height: CGFloat = 60) -> some View {
        self.frame(width: width, height: height)
            .background(Color.blue)
            .foregroundColor(.white)
            .font(.title2.bold())
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 6)
    }
}

