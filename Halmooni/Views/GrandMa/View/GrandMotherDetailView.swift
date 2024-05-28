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
    @State private var dragOffset: CGFloat = 0.0
    @State private var isDragging = false
    
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
                        Text("나가기")
                            .padding()
                            .foregroundStyle(Color.white)
                            .frame(width: 240, height: 95)
                            .dynamicTypeSize(.accessibility2)
                            .font(.largeTitle.bold())
                            .background(
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(Color.prim)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color.str, lineWidth: 5)
                                )

                    })
                }
                .padding(.top, 50)
                .padding(.trailing, 57)
                
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
                    Button(action: {
                        guard let path = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents") else {
                            return
                        }
                        let fileName = diary.recordUrl!.split(separator: "/").last!
                        let fileUrl = path.appendingPathComponent(String(fileName))
                        
                        if audioController.isPlaying {
                            audioController.pauseAudio()
                        } else {
                            audioController.startAudio(filePath: fileUrl)
                        }
                        
                    }) {
                        //TODO: 다시듣기 비활성화 & 활성화 시키기
//                        Image(systemName: audioController.isPlaying ? "pause.fill" : "play.fill")
//                            .imageScale(.large)
//                            .foregroundColor(Color.prim)
                    }
                    if let duration = audioController.audioLength, let currentTime = audioController.time {
                        /* ProgressBar(value: CGFloat(currentTime / duration))
                         .frame(height: 4)
                         .padding(.horizontal, 20)
                         .padding(.top, 8)*/
                        //ProgressBarBar(diary: diary)
                        //수정 버전
                        ProgressView(value: audioController.time, total: duration)
                            .accentColor(Color.gry)
                            .progressViewStyle(LinearProgressViewStyle())
                            .overlay(
                                GeometryReader { geometry in
                                    Circle()
                                        .frame(width: 10, height: 10)
                                        .foregroundColor(.gry)
                                        .offset(x: CGFloat(currentTime / duration) * geometry.size.width - 9, y: -3)
                                        .gesture(
                                            DragGesture()
                                                .onChanged { value in
                                                    isDragging = true
                                                    dragOffset = min(max(0, value.location.x), geometry.size.width)
                                                    let newTime = TimeInterval(dragOffset / geometry.size.width) * duration
                                                    audioController.updateCurrentTime(to: newTime)
                                                }
                                                .onEnded { value in
                                                    isDragging = false
                                                    let newTime = TimeInterval(dragOffset / geometry.size.width) * duration
                                                    audioController.seek(to: newTime)
                                                }
                                        )
                                    
                                }
                            )
                            .padding(.vertical, 30)
                            .padding(.horizontal, 233)
                        
                        
                    }
                    
                
            
                case .failed:
                    Text("저장 실패 ㅋ")
                }
                
            }
        }
        .onAppear {
            viewModel.downloadRecordFile(url: self.diary.recordUrl!)
        }
        .onDisappear {
            self.audioController.stopAudio()
        }
        .onChange(of: viewModel.status) {
            if viewModel.status == .success {
                guard let path = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents") else {
                    return
                }
                let fileName = diary.recordUrl!.split(separator: "/").last!
                let fileUrl = path.appendingPathComponent(String(fileName))
                
                audioController.startAudio(filePath: fileUrl)
            }
        }
        
    }
    
    @ViewBuilder
    private func audioButtonView() -> some View {
        
    }
}

struct ProgressBar: View {
    var value: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.gray.opacity(0.3))
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                Rectangle()
                    .foregroundColor(.prim)
                    .frame(width: min(self.value * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .animation(.linear)
            }
        }
    }
}
/*

struct ProgressBarBar: View {
    //@ObservedObject var audioController: AudioController // Ensure you have an ObservableObject named AudioController
    
    @State private var audioController: AudioController = AudioController()
    @State private var isDragging = false
    @State private var dragOffset: CGFloat = 0
    
    var diary: Diary // Ensure Diary has a property `recordUrl`
    
    var body: some View {
        VStack {
            if let path = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents"),
               let recordUrl = diary.recordUrl {
                let fileName = recordUrl.split(separator: "/").last!
                let fileUrl = path.appendingPathComponent(String(fileName))
                
                ProgressView(value: audioController.time, total: audioController.audioLength ?? 1)
                    .accentColor(Color.gray)
                    .progressViewStyle(LinearProgressViewStyle())
                    .overlay(
                        GeometryReader { geometry in
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.gray)
                                .offset(x: (CGFloat(audioController.time!) / CGFloat(audioController.audioLength ?? 1)) * geometry.size.width - 5, y: -5)
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            isDragging = true
                                            dragOffset = min(max(0, value.location.x), geometry.size.width)
                                            let newTime = TimeInterval(dragOffset / geometry.size.width) * (audioController.audioLength ?? 1)
                                            audioController.updateCurrentTime(to: newTime)
                                        }
                                        .onEnded { value in
                                            isDragging = false
                                            let newTime = TimeInterval(dragOffset / geometry.size.width) * (audioController.audioLength ?? 1)
                                            audioController.seek(to: newTime)
                                        }
                                )
                        }
                    )
                    .padding(.horizontal)
                
                HStack {
                    if audioController.isPlaying {
                        Button(action: {
                            audioController.pauseAudio()
                        }) {
                            Image(systemName: "pause.fill")
                                .imageScale(.large)
                                .foregroundColor(Color.primary)
                        }
                    } else {
                        Button(action: {
                            audioController.startAudio(filePath: fileUrl)
                        }) {
                            Image(systemName: "play.fill")
                                .imageScale(.large)
                                .foregroundColor(Color.primary)
                        }
                    }
                }
            } else {
                Text("Unable to load audio file.")
            }
        }
        .padding()
    }
}
*/
