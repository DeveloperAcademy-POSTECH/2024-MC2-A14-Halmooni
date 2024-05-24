//
//  GrandMotherDetailView.swift
//  grandmother
//
//  Created by Kyu Im on 5/17/24.
//
import SwiftUI
import AVKit

struct GrandMotherDetailView: View {
    
    @StateObject private var audioRecorder = AudioRecorder()
    @Binding var showDetailView: Bool
    var animationNamespace: Namespace.ID
    @StateObject var audioPlayerViewModel = AudioPlayerViewModel()
    
    let diary: Diary
    @State private var isPlaying: Bool = false
    @State private var player: AVPlayer?
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.section
            VStack {
                HStack {
                    Text(diary.savedDate!.engToKor())
                        .dynamicTypeSize(.xxxLarge)
                        .font(.largeTitle.bold())
                        .padding(.leading, 50)
                    Spacer()
                    Button(action: {
                        withAnimation(.spring()) {
                            showDetailView = false
                        }
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .dynamicTypeSize(.xxxLarge)
                            .font(.title)
                            .foregroundColor(.prim)
                            .padding(.trailing, 50)
                    })
                }
                .padding(.top, 50)
                
                HStack {
                    if let imageData = diary.image, let imageData = UIImage(data: imageData) {
                        Image(uiImage: imageData)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 450, height: 600)
                            .matchedGeometryEffect(id: "photo\(String(describing: diary.id))", in: animationNamespace)
                    } else {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray)
                            .frame(width: 450, height: 600)
                            .overlay {
                                Text("No Image")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                            .matchedGeometryEffect(id: "photo\(String(describing: diary.id))", in: animationNamespace)
                    }
                    Spacer()
                    Image("\(diary.pickedTemplate)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 450, height: 600)
                }
                .padding(.horizontal, 50)
                
                Button(action: {
                    if isPlaying {
                        // Pause the audio
                        player?.pause()
                    } else {
                        // Start playing the audio
                        guard let path = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appending(path: "Documents") else {
                            return
                        }
                        let url = path.appending(path: "\(diary.id!.uuidString).m4a")
                        player = AVPlayer(url: url)
                        player?.play()
                    }
                    // Toggle the state
                    isPlaying.toggle()
                }, label: {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .imageScale(.large)
                        .foregroundColor(Color.prim)
                })
                
                AudioPlayView(audioRecorder: audioRecorder)
            }
        }
        .onDisappear {
            // Stop the audio when view disappears
            player?.pause()
        }
    }
}


//struct GrandMotherDetailView_Previews: PreviewProvider {
//    @State static var showDetailView = true
//    @Namespace static var animationNamespace
//
//    static var previews: some View {
//        GrandMotherDetailView(showDetailView: $showDetailView, animationNamespace: animationNamespace)
//    }
//}

