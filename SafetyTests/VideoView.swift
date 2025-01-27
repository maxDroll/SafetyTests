//
//  VideoView.swift
//  SafetyTests
//
//  Created by Maxwell K. Droll on 1/23/25.
//

import SwiftUI

struct VideoView: View {
    @Binding var selectedMachine: String
    var body: some View {
        switch selectedMachine{
        case "Mille":YoutubeVideo(videoID: "Rm1FXXOH6KU")
        case "Angle Grinder": YoutubeVideo(videoID: "etBFbmNevWs")
        case "Lathe": YoutubeVideo(videoID: "PKQPey6L42M")
        default: YoutubeVideo(videoID: "IK_Cn5lxggA")
        }
    }
}


