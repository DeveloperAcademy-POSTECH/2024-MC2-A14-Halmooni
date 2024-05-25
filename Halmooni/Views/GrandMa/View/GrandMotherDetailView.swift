//
//  GrandMotherDetailView.swift
//  grandmother
//
//  Created by Kyu Im on 5/17/24.
//
import SwiftUI
import AVKit

struct GrandMotherDetailView: View {
    @State private var viewModel: AudioViewModel = AudioViewModel()
    @State private var audioController: AudioController = AudioController()
    @Binding var showDetailView: Bool
    
    var animationNamespace: Namespace.ID
    
    let diary: Diary
    let index: Int
    
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
                            .matchedGeometryEffect(id: "\(index)", in: animationNamespace)
                            .scaledToFit()
                            .frame(width: 450, height: 600)
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
                
                switch self.viewModel.status {
                case .loading:
                    ProgressView()
                        .progressViewStyle(.circular)
                case .success:
                    Button("재생") {
                        guard let path = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appending(path: "Documents") else {
                            return
                        }
                        let fileName = diary.recordUrl!.split(separator: "/").last!
                        let fileUrl = path.appending(path: fileName)
                        
                        audioController.startAudio(filePath: fileUrl)
                    }
                case .failed:
                    Text("저장 실패 ㅋ")
                }
                
//                Button(action: {
//                    if isPlaying {
//                        // Pause the audio
//                        player?.pause()
//                    } else {
//                        isPlaying = false
//                        // Start playing the audio
//                        guard let path = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appending(path: "Documents") else {
//                            return
//                        }
//                        let fileName = diary.recordUrl!.split(separator: "/").last!
//                        let fileUrl = path.appending(path: fileName)
//                        
//                        if FileManager.default.fileExists(atPath: path.relativePath) {
//                            print("444444444")
//                        }
//                        
//                        try! FileManager.default.startDownloadingUbiquitousItem(at: fileUrl)
//                        
//                        player = AVPlayer(url: fileUrl)
//                        player?.play()
//                    }
//                    // Toggle the state
//                    isPlaying.toggle()
//                }, label: {
//                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
//                        .imageScale(.large)
//                        .foregroundColor(Color.prim)
//                })
                
//                AudioPlayView(audioRecorder: audioRecorder)
            }
        }
        .onAppear {
            viewModel.downloadRecordFile(url: self.diary.recordUrl!)
        }
        .onDisappear {
            // Stop the audio when view disappears
            self.audioController.stopAudio()
        }
    }
    
    @ViewBuilder
    private func audioButtonView() -> some View {
        
    }
}

