//
//  AddDiaryRecordView.swift
//  Halmooni
//
//  Created by 문인범 on 5/20/24.
//

import SwiftUI


struct AddDiaryRecordView: View {
    @Binding var viewModel: AudioController
    
    @Binding var recordURL: URL?
    @Binding var recordTime: TimeInterval?
    @Binding var randomTheme: String?
    
    let uuid: UUID
    
    var body: some View {
        VStack {
            Spacer()

            HStack(spacing: 4) {
                ForEach(viewModel.soundSamples, id: \.self) { level in
                    if !viewModel.isRecorded {
                        AudioVisualizerView(value: 30)
                    } else {
                        AudioVisualizerView(value: nomalizeSoundLevel(level: level))
                    }
                }
            }
            .frame(height: 250)

            if let randomTheme = randomTheme {
                Text(randomTheme)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.text)
            }
            
            
            Text("사용자에게 있어서 할머니와의 소통 주제를\nTo.Halmooni가 자동으로 제안하여\n메시지 녹음을 더 쉽게 시작할 수 있도록 돕습니다.")
                .font(.caption)
                .foregroundStyle(.gry)
                .multilineTextAlignment(.center)
                .padding(.top, 6)
                .padding(.bottom, 27)

            if viewModel.time == nil {
                Text("00:00.00")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 40)
            } else {
                Text(viewModel.time!.getTimeString())
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 40)
            }
            
            recordButtonView()
            
            Spacer()
        }
        .navigationTitle("메시지 녹음")
        .background(.bg)
        .task {
            if !viewModel.isRecordPermissionGranted {
                await viewModel.getRecordPermission()
            }
        }
        .onDisappear {
            if viewModel.isRecorded {
                recordURL = viewModel.fileURL
                recordTime = viewModel.audioLength
            }
        }
    }
}

// MARK: - 녹음 분기에 따른 뷰
extension AddDiaryRecordView {
    @ViewBuilder
    private func recordButtonView() -> some View {
        // 처음 녹음 시작할 때
        if !viewModel.isRecorded {
            Button {
                viewModel.startRecording(id: uuid)
            } label: {
                Image(systemName: "record.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45)
            }
        } else {
            VStack {
                HStack {
                    Button {
                        viewModel.backwardFifteen()
                    } label: {
                        Image(systemName: "gobackward.15")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 30, height: 30)
                    }
                    .disabled(viewModel.isRecording)
                    
                    Button {
                        if !viewModel.isPlaying {
                            viewModel.startAudio(filePath: nil)
                        } else {
                            viewModel.stopAudio()
                        }
                    } label: {
                        if !viewModel.isPlaying {
                            Image(systemName: "play.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 45, height: 45)
                        } else {
                            Image(systemName: "stop.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 45, height: 45)
                        }
                    }
                    .disabled(viewModel.isRecording)
                    .padding(.leading, 40)
                    .padding(.trailing, 30)
                    
                    Button {
                        viewModel.forwardFifteen()
                    } label: {
                        Image(systemName: "goforward.15")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 30, height: 30)
                    }
                    .disabled(viewModel.isRecording)
                }
                .padding(.bottom, 80)
                
                Button {
                    if !viewModel.isRecording {
                        viewModel.resetRecording()
                        recordTime = nil
                        // 초기화 진행 시 새로운 랜덤 변수 생성
                        if let random = randomThemes.randomElement() {
                            randomTheme = random
                        }
                    } else {
                        viewModel.stopRecording()
                    }
                } label: {
                    if !viewModel.isRecording {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(lineWidth: 4)
                                .foregroundStyle(.prim)
                                .frame(width: 108, height: 50)
                            
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(.sec)
                                .frame(width: 108, height: 50)
                            
                            Text("초기화")
                        }
                    } else {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(lineWidth: 4)
                                .foregroundStyle(.gry)
                                .frame(width: 108, height: 50)
                            
                            Image(systemName: "pause.fill")
                                .foregroundStyle(.prim)
                        }
                    }
                }
            }
        }
    }
    
    private func nomalizeSoundLevel(level: Float) -> CGFloat {
        let level = max(0.2, CGFloat(level) + 50) / 2
        return CGFloat(level * 300 / 25)
    }
}


