//
//  AudioPlayView.swift
//  Halmooni
//
//  Created by 추서연 on 5/21/24.
//

import SwiftUI

struct AudioPlayView: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
        List {
            ForEach(audioRecorder.recordings, id: \.createdAt) { recording in
                RecordingRow(audioURL: recording.fileURL)
            }
        }
    }
}
struct RecordingRow: View {
    
    var audioURL: URL
    
    @ObservedObject var audioPlayer = AudioPlayer()
    @State private var dragOffset: CGFloat = 0.0
    @State private var isDragging = false
    
    var body: some View {
        VStack {
            //녹음 제목
            //Text("\(audioURL.lastPathComponent)")
            
            ProgressView(value: audioPlayer.currentTime, total: audioPlayer.duration)
                .accentColor(Color.gry)
                .progressViewStyle(LinearProgressViewStyle())
            
                .overlay(
                    GeometryReader { geometry in
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.gry)
                            .offset(x: CGFloat(audioPlayer.currentTime / audioPlayer.duration) * geometry.size.width - 9, y: -3)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        isDragging = true
                                        dragOffset = min(max(0, value.location.x), geometry.size.width)
                                        let newTime = TimeInterval(dragOffset / geometry.size.width) * audioPlayer.duration
                                        audioPlayer.updateCurrentTime(to: newTime)
                                    }
                                    .onEnded { value in
                                        isDragging = false
                                        let newTime = TimeInterval(dragOffset / geometry.size.width) * audioPlayer.duration
                                        audioPlayer.seek(to: newTime)
                                    }
                            )
                        
                    }
                )
            HStack{
                if audioPlayer.isPlaying || audioPlayer.isPaused {
                    HStack {
                        Text("\(timeString(from: audioPlayer.currentTime))")
                            .foregroundColor(Color.gry2)
                        Spacer()
                        Text("-\(timeString(from: audioPlayer.duration - audioPlayer.currentTime))")
                            .foregroundColor(Color.gry)
                    }
                    .padding(.top, 5)
                }
            }.frame(height: 10)
            
            controlButton()
            
        }
        .padding()
    }
    
    private func controlButton() -> some View {
        HStack {
            if audioPlayer.isFinished || (!audioPlayer.isPlaying && !audioPlayer.isPaused) {
                Button(action: {
                    self.audioPlayer.startPlayback(audio: self.audioURL)
                }) {
                    Image(systemName: "play.fill")
                        .imageScale(.large)
                        .foregroundColor(Color.prim)
                }
            } else if audioPlayer.isPlaying {
                Button(action: {
                    self.audioPlayer.pausePlayback()
                }) {
                    Image(systemName: "pause.fill")
                        .imageScale(.large)
                        .foregroundColor(Color.prim)
                }
            } else {
                Button(action: {
                    self.audioPlayer.resumePlayback()
                }) {
                    Image(systemName: "play.fill")
                        .imageScale(.large)
                        .foregroundColor(Color.prim)
                }
            }
        }
    }
    
    private func timeString(from timeInterval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: timeInterval)!
    }
}


#Preview {
    AudioPlayView(audioRecorder: AudioRecorder())
}
