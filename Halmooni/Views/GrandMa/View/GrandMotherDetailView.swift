//
//  GrandMotherDetailView.swift
//  grandmother
//
//  Created by Kyu Im on 5/17/24.
//
import SwiftUI
import AVKit

struct GrandMotherDetailView: View {
    
//    @StateObject private var audioRecorder = AudioRecorder()
    @Binding var showDetailView: Bool
    var animationNamespace: Namespace.ID
//    @StateObject var audioPlayerViewModel = AudioPlayerViewModel()
    
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
//                            .matchedGeometryEffect(id: "photo\(String(describing: diary.id))", in: animationNamespace)
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
                        
                        player = AVPlayer(url: fileUrl)
                        player?.play()
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
            player?.pause()
        }
    }
    
    @ViewBuilder
    private func audioButtonView() -> some View {
        
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


@Observable
class TestModel {
    public var status: ModelStatus = .loading
    
    public func downloadRecordFile(url: String) {
        guard let path = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appending(path: "Documents") else {
            print("failed to make url")
            return
        }
        let fileName = url.split(separator: "/").last!
        let fileUrl = path.appending(path: fileName)
        
        do {
            try FileManager.default.startDownloadingUbiquitousItem(at: fileUrl)
        } catch {
            self.status = .failed
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.status = .success
        }
    }
    
    enum ModelStatus {
        case loading
        case success
        case failed
    }
}
