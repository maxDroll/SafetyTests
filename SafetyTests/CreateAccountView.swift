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


struct CreateAccountView: View {
    @FirestoreQuery(collectionPath: "Students") var students:[Student]
    @State private var enterName: String = ""
    @State var enterClass: String = ""
    
    var body: some View {
        NavigationStack{
            VStack {
                TextField("Enter Name", text: $enterName)
                TextField("Enter Class", text:$enterClass)
                NavigationLink(destination: ContentView()) {
                    Button {
                        CreateAccount()
                    } label: {
                        Text("Create Account")
                    }

                }
            }
        }
    }
    func CreateAccount(){
        let database = Firestore.firestore()
        database.collection("Students").document(enterName).setData(["name":enterName,"Teacher":false,"AngleGrinderTest":-1,"AngleGrinderVideo":false,"Class":enterClass,"LatheTest":-1,"LatheVideo":false,"MillTest":-1,"MillVideo":false,"WelderTest":-1,"WelderVideo":false])
        enterName = ""
        enterClass = ""
    }
}
