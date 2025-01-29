//
//  StudentMachineView.swift
//  SafetyTests
//
//  Created by Maxwell K. Droll on 12/13/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import SwiftData

struct StudentMachineView: View {
    @AppStorage("name") var name = ""
    @AppStorage("class") var Class = ""
    @State var machines:[machineInfo] = []
    @Binding var selectedMachine: String
    @State private var hasWatchedVideo: Bool = false
    @Environment(\.modelContext) var context
    @Query var stud:[StudentData] = []
    @FirestoreQuery(collectionPath: "Students") var students:[Student]
    var body: some View {
        VStack{
            if selectedMachine == ""{
                Text("Select a Machine")
                    .font(.largeTitle)
            }
            else{
                Text(selectedMachine)
                Text("Some Safety Advice")
                VStack(alignment: .leading) {
                    Text("Bullet Points")
                    Text("Bullet Points")
                    
                }
                ForEach(machines, id:\.self) { machine in
                    if machine.name == selectedMachine{
                        Text("\(machine.video)")
                        Text("\(machine.test)")
                        Text("You have \(machine.video ? "watched" : "not watched") the video.")
                    }
                }
                NavigationLink("Go to Quiz View") {
                    quizView(machines: $machines, selectedMachine: $selectedMachine)
                }
                NavigationLink("Go to Video View"){
                    VideoView(selectedMachine: $selectedMachine)
                }
                Button(action: {
                    switch selectedMachine{
                    case "Mille":stud[0].MillVideo.toggle()
                    case "Angle Grinder":stud[0].AngleGrinderVideo.toggle()
                    case "Lathe": stud[0].LatheVideo.toggle()
                    default: stud[0].WelderVideo.toggle()
                    }
                    machineStatusUpdate()
                }) {
                    Text(hasWatchedVideo ? "Mark as Not Watched" : "Mark as Watched")
                    
                }
                .padding(.bottom)
                
            }
        }
        .frame(width: 600, height: 1000)
        .onAppear{
            machineStatusUpdate()
        }
            
    }
    func machineStatusUpdate(){
        machines = [machineInfo(name: "Mille", test: stud[0].MillTest, video: stud[0].MillVideo, videoID: "PKQPey6L42M"),machineInfo(name: "Angle Grinder", test: stud[0].AngleGrinderTest, video: stud[0].AngleGrinderVideo, videoID: "PKQPey6L42M"),machineInfo(name: "Lathe", test: stud[0].LatheTest, video: stud[0].LatheVideo, videoID: "PKQPey6L42M"),machineInfo(name: "Welder", test: stud[0].WelderTest, video: stud[0].WelderVideo, videoID: "PKQPey6L42M")]
        let database = Firestore.firestore()
        database.collection("Students").document(stud[0].name).setData(["name":stud[0].name,"Teacher":stud[0].Teacher,"AngleGrinderTest":stud[0].AngleGrinderTest,"AngleGrinderVideo":stud[0].AngleGrinderVideo,"Class":stud[0].Class,"LatheTest":stud[0].LatheTest,"LatheVideo":stud[0].LatheVideo,"MillTest":stud[0].MillTest,"MillVideo":stud[0].MillVideo,"WelderTest":stud[0].WelderTest,"WelderVideo":stud[0].WelderVideo])
    }
}
