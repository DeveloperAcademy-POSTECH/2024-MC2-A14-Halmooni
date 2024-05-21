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
    
    var body: some View {
        VStack {
            Text("\(audioURL.lastPathComponent)")
            
            
            ProgressView(value: audioPlayer.currentTime, total: audioPlayer.duration)
                .accentColor(Color.gry)
                .progressViewStyle(LinearProgressViewStyle())
            HStack{
                if audioPlayer.isPlaying {
                                HStack {
                                    Text("\(timeString(from: audioPlayer.currentTime))")
                                        .foregroundColor(Color.gry)
                                    Spacer()
                                    Text("-\(timeString(from: audioPlayer.duration - audioPlayer.currentTime))")
                                        .foregroundColor(Color.gry)
                                }
                                .padding(.top, 5)
                            }
            }.frame(height: 10)
            
            HStack {
                if audioPlayer.isFinished {
                    Button(action: {
                        self.audioPlayer.startPlayback(audio: self.audioURL)
                    }) {
                        Image(systemName: "repeat")
                            .imageScale(.large)
                            .foregroundColor(Color.prim)
                    }
                } else if audioPlayer.isPlaying == false {
                    Button(action: {
                        self.audioPlayer.startPlayback(audio: self.audioURL)
                    }) {
                        Image(systemName: "play.fill")
                            .imageScale(.large)
                            .foregroundColor(Color.prim)
                    }
                } else {
                    Button(action: {
                        self.audioPlayer.stopPlayback()
                    }) {
                        Image(systemName: "pause.fill")
                            .imageScale(.large)
                            .foregroundColor(Color.prim)
                    }
                }
            }
            
        }
        .padding()
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
