//
//  AudioRecordButton.swift
//  Halmooni
//
//  Created by 추서연 on 5/21/24.
//

import SwiftUI

struct AudioRecordButton: View {
    
    @State var isAnimating = false
    @State var recordingName = ""
    @ObservedObject var audioPlayer = AudioPlayer()
    @ObservedObject var audioRecorder: AudioRecorder

    var body: some View {
        if audioRecorder.recording == false {
            ZStack {
                Button {
                    self.audioRecorder.startRecording(name: recordingName)
                    recordingName = ""
                    withAnimation(.easeInOut(duration: 1).repeatForever()) {
                        isAnimating.toggle()
                    }
                } label: {
                    RecordCircle()
                }
            }
            .frame(height: 130)
        }
        else {
            ZStack {
                Circle()
                    .frame(width: 130)
                    .foregroundStyle(Color.prim)
                    .opacity(isAnimating ? 0.3 : 0)
                Circle()
                    .frame(width: 105)
                    .foregroundStyle(Color("RecordGray"))
                    .opacity(isAnimating ? 0.5 : 0)
                Button {
                    self.audioRecorder.stopRecording()
                } label: {
                    RecordRectangle()
                }
            }
            .frame(height: 130)
        }
        Spacer()
            .frame(height: 50)
        
    }
}

struct RecordRectangle: View {
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 80)
                .foregroundStyle(Color.prim)
            Rectangle()
                .frame(width: 30, height: 30)
                .foregroundStyle(Color.bg)
        }
    }
}

struct RecordCircle: View {
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 80)
                .foregroundStyle(Color.bg)
            Circle()
                .frame(width: 40)
                .foregroundStyle(Color.prim)
        }
    }
}



#Preview {
    AudioRecordButton(audioRecorder: AudioRecorder())
}
