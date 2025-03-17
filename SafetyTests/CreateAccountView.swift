//
//  CreateAccountView.swift
//  SafetyTests
//
//  Created by Eric M. Wetzel on 12/11/24.
//

import SwiftUICore
import SwiftUI
import Firebase
import FirebaseFirestore
import SwiftData

struct CreateAccountView: View {
    @Environment(\.modelContext) var context
    @Query var student:[StudentData] = []
    @FirestoreQuery(collectionPath: "Students") var students:[Student]
    @AppStorage("name") var name = ""
    @AppStorage("class") var Class = ""
    @AppStorage("ID") var ID = ""
    @State private var enterName: String = ""
    @State var enterClass: String = ""
    @State var enterID: String = ""
    
    var body: some View {
        NavigationStack{
            Text("Hi! Welcome to")
                .font(.system(size:50))
            Text("Hersey Safety XS")
                .font(.system(size:50))
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 400, height: 300)
                    .foregroundStyle(Color(uiColor: .lightGray))
                VStack {
                    Text("Create an Account")
                        .offset(x:-50)
                        .font(.title)
                    Spacer()
                    TextField("Enter Name", text: $enterName)
                        .frame(width: 300)
                        .textFieldStyle(.roundedBorder)
                        .font(.title)
                    TextField("Enter Class Code", text:$enterClass)
                        .frame(width: 300)
                        .textFieldStyle(.roundedBorder)
                        .font(.title)
                    TextField("Enter Student ID", text: $enterID)
                        .frame(width: 300)
                        .textFieldStyle(.roundedBorder)
                        .font(.title)
                    Spacer()
                    NavigationLink(destination: ContentView()) {
                        Button {
                            CreateAccount()
                        } label: {
                            Text("Create Account")
                                .foregroundColor(.white)
                                .frame(width: 150, height: 40)
                                .background(Color.blue)
                                .font(.title2)
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                                .offset(x:50)
                        }
                        .disabled(enterClass.isEmpty || enterName.isEmpty)
                    }
                    .disabled(enterClass == "" || enterName == "")
                }
                .frame(height: 250)
            }
        }
    }
    func CreateAccount(){
        let database = Firestore.firestore()
        database.collection("Students").document(enterName).setData(["name":enterName,"Teacher":false,"AngleGrinderTest":-1,"AngleGrinderVideo":false,"Class":enterClass,"LatheTest":-1,"LatheVideo":false,"MillTest":-1,"MillVideo":false,"WelderTest":-1,"WelderVideo":false,"StudentID": enterID])
        
        let student = StudentData(AngleGrinderTest: -1, AngleGrinderVideo: false, Class: enterClass, LatheTest: -1, LatheVideo: false, MillTest: -1, MillVideo: false, WelderTest: -1, WelderVideo: false, name: enterName, Teacher: false)
        context.insert(student)
        name = enterName
        Class = enterClass
        ID = enterID
        enterName = ""
        enterClass = ""
        enterID = ""
    }
}
