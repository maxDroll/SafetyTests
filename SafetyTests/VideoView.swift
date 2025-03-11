//
//  VideoView.swift
//  SafetyTests
//
//  Created by Maxwell K. Droll on 1/23/25.
//

import SwiftUI
import SwiftData

struct VideoView: View {
    @Binding var selectedMachine: String
    @Environment(\.modelContext) var context
    @Query var stud:[StudentData] = []
    var body: some View {
        switch selectedMachine{
        case "Mill":YoutubeVideo(videoID: "Rm1FXXOH6KU")
        case "Angle Grinder": YoutubeVideo(videoID: "etBFbmNevWs")
        case "Lathe": YoutubeVideo(videoID: "PKQPey6L42M")
        default: YoutubeVideo(videoID: "IK_Cn5lxggA")
        }
        Button(action: {
            switch selectedMachine{
            case "Mill":stud[0].MillVideo.toggle()
            case "Angle Grinder":stud[0].AngleGrinderVideo.toggle()
            case "Lathe": stud[0].LatheVideo.toggle()
            default: stud[0].WelderVideo.toggle()
            }
        }) {
            switch selectedMachine{
            case "Mill":Text(stud[0].MillVideo ? "Mark as Not Watched" : "Mark as Watched")
            case "Angle Grinder": Text(stud[0].AngleGrinderVideo ? "Mark as Not Watched" : "Mark as Watched")
            case "Lathe": Text(stud[0].LatheVideo ? "Mark as Not Watched" : "Mark as Watched")
            default: Text(stud[0].WelderVideo ? "Mark as Not Watched" : "Mark as Watched")
            }
            
        }
    }
}


