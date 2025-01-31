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
                    .font(.largeTitle)
                Text("Some general Safety Advice")
                    .padding()
                VStack(alignment: .leading) {
                    Text("Bullet Points about safety gear")
                    Text("Bullet Points about safety gear")
                    
                }
                .padding()
                .padding()
                HStack{
                    VStack{
                        NavigationLink {
                            VideoView(selectedMachine: $selectedMachine)
                        } label: {
                            Text("Go to Video View")
                                .frame(width: 250, height: 100)
                                .background(.blue)
                                .foregroundStyle(.white)
                                .font(.title)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        NavigationLink {
                            quizView(machines: $machines, selectedMachine: $selectedMachine)
                        } label: {
                            Text("Go to Quiz View")
                                .frame(width: 250, height: 100)
                                .background(.blue)
                                .foregroundStyle(.white)
                                .font(.title)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    VStack{
                        ForEach(machines, id:\.self) { machine in
                            if machine.name == selectedMachine{
                                Text("You have \(machine.video ? "watched" : "not watched") the video.")
                                    .frame(width: 200, height: 100)
                                Text("You have gotten a \(machine.test) on the test")
                                    .frame(width: 200, height: 100)
                            }
                        }
                    }
                }
                
            }
        }
        .frame(width: 600, height: 1000)
        .onAppear{
            machineStatusUpdate()
//            for element in stud{
//                context.delete(element)
//            }
        }
            
    }
    func machineStatusUpdate(){
//        name = ""
//        Class = ""
        machines = [machineInfo(name: "Mille", test: stud[0].MillTest, video: stud[0].MillVideo, videoID: "PKQPey6L42M"),machineInfo(name: "Angle Grinder", test: stud[0].AngleGrinderTest, video: stud[0].AngleGrinderVideo, videoID: "PKQPey6L42M"),machineInfo(name: "Lathe", test: stud[0].LatheTest, video: stud[0].LatheVideo, videoID: "PKQPey6L42M"),machineInfo(name: "Welder", test: stud[0].WelderTest, video: stud[0].WelderVideo, videoID: "PKQPey6L42M")]
        let database = Firestore.firestore()
        database.collection("Students").document(stud[0].name).setData(["name":stud[0].name,"Teacher":stud[0].Teacher,"AngleGrinderTest":stud[0].AngleGrinderTest,"AngleGrinderVideo":stud[0].AngleGrinderVideo,"Class":stud[0].Class,"LatheTest":stud[0].LatheTest,"LatheVideo":stud[0].LatheVideo,"MillTest":stud[0].MillTest,"MillVideo":stud[0].MillVideo,"WelderTest":stud[0].WelderTest,"WelderVideo":stud[0].WelderVideo])
    }
}
