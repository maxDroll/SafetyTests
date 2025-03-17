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
    @State var ShowAlert1 = false
    @State var ShowAlert2 = false
    @State var enteredPassword = ""
    @State var correctPassword = false
    @Environment(\.modelContext) var context
    @Query var stud:[StudentData] = []
    @FirestoreQuery(collectionPath: "Students") var students:[Student]
    var body: some View {
        if let screenSize = UIScreen.main.bounds as CGRect? {
            VStack{
                if selectedMachine == ""{
                    Text("Select a Machine")
                        .font(.largeTitle)
                }
                else{
                    Text(selectedMachine)
                        .font(.largeTitle)
                        .padding()
                    ZStack{
                        VStack(alignment: .leading) {
                            if selectedMachine == "Mill" {
                                Text("Required PPE: Safety Glasses")
                                Text("Reminders: ")
                                Text("Remove rings, watches, and bracelets")
                                Text("Roll up long sleeves")
                                Text("Tie back long hair")
                            }
                            if selectedMachine == "Lathe" {
                                Text("Required PPE: Safety Glasses")
                                Text("Reminders: ")
                                Text("Remove rings, watches, and bracelets")
                                Text("Roll up long sleeves")
                                Text("Tuck in or remove necklaces and hoodie strings")
                                Text("Tie back long hair")
                            }
                            if selectedMachine == "Welder" {
                                Text("Required PPE: Safety Glasses, Face Shield, Leather Gloves")
                                Text("Reminders: ")
                                Text("Check that your mask is functioning properly and is a minimum shade 10")
                                Text("Remove any flammable materials from the surrounding area")
                                Text("Always allow parts to cool before handling")
                                
                            }
                            if selectedMachine == "Angle Grinder" {
                                Text("Required PPE: Safety Glasses, Face Shield, Leather Gloves")
                                Text("Reminders: ")
                                Text("Ensure that your workpiece is properly secured")
                                Text("Remove any flammable materials from the surrounding area")
                                Text("Get a strong base and use two hands at all times")
                            }
                        }
                        Button {
                            ShowAlert1 = true
                        } label: {
                            Text("Admin reset")
                                .foregroundStyle(.white)
                                .frame(width: 100, height: 25)
                                .background(.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                        .offset(x: 250, y: -300)
                        .alert("Class Reset", isPresented: $ShowAlert1, actions: {
                            TextField("Admin Password", text: $enteredPassword)
                            Button("Enter", role: .cancel, action: {
                                if enteredPassword == "12345"{
                                    ShowAlert2 = true
                                    enteredPassword = ""
                                }
                            })
                        }, message: {
                            Text("Please Enter Admin Password")
                        })
                        .alert("Reset Class", isPresented: $ShowAlert2, actions: {
                            TextField("New Class", text: $Class)
                            Button("Enter", role: .cancel, action: {
                                stud[0].Class = Class
                                machineStatusUpdate()
                            })
                        }, message: {
                            Text("Please Enter New Class")
                        })
                        
                    }
                    
                    
                    
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
                                    .navigationBarBackButtonHidden(true)
                                //                                quizViewV2(selectedMachine: $selectedMachine)
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
                                    if machine.test == -1{
                                        Text("You have not taken the quiz")
                                            .frame(width: 200, height: 100)
                                    }else{
                                        Text("You have gotten a \(machine.test) on the quiz")
                                            .frame(width: 200, height: 100)
                                    }
                                }
                            }
                        }
                    }
                    
                }
            }
            .frame(width: (screenSize.width * (6 / 12)), height: 1000)
            .onAppear{
                machineStatusUpdate()
            }
        }
    }
    func machineStatusUpdate(){
        //Reset Account
        
        //                    name = ""
        //                    Class = ""
        //            for element in stud{
        //                context.delete(element)
        //            }
        //
        
        machines = [machineInfo(name: "Mill", test: stud[0].MillTest, video: stud[0].MillVideo, videoID: "PKQPey6L42M"),machineInfo(name: "Angle Grinder", test: stud[0].AngleGrinderTest, video: stud[0].AngleGrinderVideo, videoID: "PKQPey6L42M"),machineInfo(name: "Lathe", test: stud[0].LatheTest, video: stud[0].LatheVideo, videoID: "PKQPey6L42M"),machineInfo(name: "Welder", test: stud[0].WelderTest, video: stud[0].WelderVideo, videoID: "PKQPey6L42M")]
        let database = Firestore.firestore()
        database.collection("Students").document(stud[0].name).setData(["name":stud[0].name,"Teacher":stud[0].Teacher,"AngleGrinderTest":stud[0].AngleGrinderTest,"AngleGrinderVideo":stud[0].AngleGrinderVideo,"Class":stud[0].Class,"LatheTest":stud[0].LatheTest,"LatheVideo":stud[0].LatheVideo,"MillTest":stud[0].MillTest,"MillVideo":stud[0].MillVideo,"WelderTest":stud[0].WelderTest,"WelderVideo":stud[0].WelderVideo])
        
    }
}

