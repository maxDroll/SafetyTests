import SwiftUI
import SwiftData
import Firebase
import FirebaseFirestore

struct quizView: View {
    @State private var selectedAnswers: [Int?] = Array(repeating: nil, count: 12)
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
            ("When operating the vertical mill, you should always wear _________.", ["Long Pants", "Safety Glasses", "Gloves", "N/A"], 1),
            ("Never allow _______ or _________ near an operating milling machine.", ["Necklaces or hair", "Coolant or oil", "Cutting tools or drills", "N/A"], 0),
            ("Metal chips should always be cleared off the machine using _______.", ["A Brush", "Air Pressure", "Latex Gloves", "No Gloves"], 0),
            ("Always remove and return drawbar wrench after changing tools.", ["True", "False", "N/A", "N/A"], 0),
            ("Firmly tighten the stock in the _________ before milling.", ["Quill", "Table", "Milling Vise", "Draw Bar"], 2),
            ("Keep hands at least _________ away from a revolving cutting tool.", ["3 inches", "6 inches", "12 inches", "N/A"], 2),
            ("The tool holding device for endmills is called a _________.", ["Drill Chuck", "Quill", "Draw Bar", "R8 Collet"], 3),
            ("You can safely use an endmill in a Drill Chuck.", ["True", "False", "N/A", "N/A"], 1),
            ("Do not move the operating levers without knowing what they control.", ["True", "False", "N/A", "N/A"], 0),
            ("Always be sure the cutting tool is spinning in the ___________ direction.", ["Counter Clockwise", "Clockwise", "N/A", "N/A"], 1),
            ("Avoid excessively heavy cuts as it may cause cutter breakage.", ["True", "False", "N/A", "N/A"], 0),
            ("Always measure your part when the machine is ____________.", ["ON", "IDLE/Neutral", "OFF", "N/A"], 2)
        ],
        "Lathe": [
            ("When operating the CNC Lathe, always wear _________.", ["Long Pants", "Safety Glasses", "Gloves", "N/A"], 1),
            ("Never allow _______ or _________ near a lathe.", ["Necklaces or hair", "Coolant or oil", "Cutting tools or drills", "N/A"], 0),
            ("Never put your hand or arm inside the parts catcher chute.", ["True", "False", "N/A", "N/A"], 0),
            ("Clear metal chips using _______ and proper gloves.", ["A Brush", "Air Pressure", "Latex Gloves", "No Gloves"], 0),
            ("Always remove and return check tightening key after loading materials.", ["True", "False", "N/A", "N/A"], 0),
            ("Tighten the stock in the _________ before turning.", ["Quill", "Table", "Center Chuck", "Draw Bar"], 2),
            ("Keep hands at least _________ from revolving tools.", ["3 inches", "6 inches", "12 inches", "N/A"], 2),
            ("Make sure that ________ jaws are holding the stock.", ["1", "2", "3", "All"], 3),
            ("Only operate with doors closed and interlocks functional.", ["True", "False", "N/A", "N/A"], 0),
            ("Do not move operating levers without understanding them.", ["True", "False", "N/A", "N/A"], 0),
            ("Ensure cutting tool is properly seated in the tool holder.", ["True", "False", "N/A", "N/A"], 0),
            ("Only measure part or finish when machine is ____________.", ["ON", "IDLE/Neutral", "OFF", "N/A"], 2)
        ],
        "Welder": [
            ("When welding, always wear _________.", ["Long Sleeves", "Welding Helmet", "Gloves", "All of the above"], 3),
            ("Never allow _______ or _________ near the welding machine.", ["Necklaces or hair", "Welding wire", "Shielding gas", "N/A"], 0),
            ("Use effective ventilation whenever possible.", ["True", "False", "N/A", "N/A"], 0),
            ("Flammable products should NOT be stored near work areas.", ["True", "False", "N/A", "N/A"], 0),
            ("Do not change weld settings unless you understand them.", ["True", "False", "N/A", "N/A"], 0),
            ("UV exposure may damage the ________ and ________.", ["Glass and wood", "Eyes and skin", "Welding machine and material", "N/A"], 1),
            ("Check auto-darkening mask ________.", ["Every time you use it", "Once a week", "Once a year", "Never"], 0),
            ("Wear clothing made from wool or cotton when welding.", ["True", "False", "N/A", "N/A"], 0),
            ("Make sure an appropriate fire extinguisher is nearby.", ["Water", "Wood", "Fire", "Situation"], 2),
            ("Protect your face from ________ using a welder's helmet.", ["Water splashing", "UV radiation", "Exhaust fumes", "N/A"], 1),
            ("It is okay to weld without full PPE.", ["True", "False", "N/A", "N/A"], 1),
            ("Shielding gas tanks must be firmly secured.", ["True", "False", "N/A", "N/A"], 0)
        ]
    ]

    var questions: [(String, [String], Int)] {
        quizzes[selectedMachine] ?? []
    }

    func calculateScore() -> Int {
        selectedAnswers.enumerated().reduce(0) { result, item in
            let (index, answer) = item
            return result + ((answer == questions[index].2) ? 1 : 0)
        }
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
                                        Text("Q\(index + 1):")
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

