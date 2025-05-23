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
    let millVideos: [String] = ["Bn5VnI4l_HA"]
    let angleGrinderVideos: [String] = ["3Nn4I8daKu4","Ak-kqSugIg4"]
    let latheVideos: [String] = ["eymXykG34YM","yJvcnqCv-wQ","iWaGRJ_jlRA","fdE7PstJv44","Bn5VnI4l_HA","vGVCsF0OQSk","pZPj1VO-OYg"]
    let welderVideos: [String] = ["rgprZTCRtAA","TO5ntFIlv6M","2Y3gS5VQSkM","jdUcJdnD6Z0","rUjIoAoxo7g","sqeZrXzsUdg",]
    @State var videoNumber: Int = 0
    @State var maxVideoNumber: Int = 0
    var body: some View {
        switch selectedMachine{
        case "Mill":YoutubeVideo(videoID: millVideos[videoNumber])
        case "Angle Grinder": YoutubeVideo(videoID: angleGrinderVideos[videoNumber])
        case "Lathe": YoutubeVideo(videoID: latheVideos[videoNumber])
        default: YoutubeVideo(videoID: welderVideos[videoNumber])
        }
        HStack(spacing: 200){
            Button {
                videoNumber -= 1
            } label: {
                Text("Previous Video")
            }
            .disabled(videoNumber == 0)
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
                        .font(.title)
                case "Angle Grinder": Text(stud[0].AngleGrinderVideo ? "Mark as Not Watched" : "Mark as Watched")
                        .font(.title)
                case "Lathe": Text(stud[0].LatheVideo ? "Mark as Not Watched" : "Mark as Watched")
                        .font(.title)
                default: Text(stud[0].WelderVideo ? "Mark as Not Watched" : "Mark as Watched")
                        .font(.title)
                }
            }
            .onAppear(){
                switch selectedMachine{
                case "Mill": maxVideoNumber = 0
                case "Angle Grinder": maxVideoNumber = 1
                case "Lathe": maxVideoNumber = 6
                default: maxVideoNumber = 5
                }
            }
            Button {
                videoNumber += 1
            } label: {
                Text("Next Video")
            }
            .disabled(videoNumber == maxVideoNumber)
        }
    }
}


