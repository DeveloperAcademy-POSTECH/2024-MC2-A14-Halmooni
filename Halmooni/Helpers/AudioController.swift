//
//  AudioController.swift
//  Halmooni
//
//  Created by 문인범 on 5/21/24.
//

import AVFoundation


@Observable
class AudioController: NSObject {
    private var audioRecorder: AVAudioRecorder?
    private var audioPlayer: AVAudioPlayer?
    private var timer: Timer?
    
    private var currentSample: Int = 0

    public var soundSamples = [Float](repeating: .zero, count: 10)
    
    public var isRecorded: Bool = false
    public var isRecording: Bool = false
    public var isPlaying: Bool = false
    
    public var time: TimeInterval?
    
    private let numberOfSamples: Int = 10
    private let recorderSettings: [String: Any] = [
        AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless),
        AVSampleRateKey: 44100.0,
        AVNumberOfChannelsKey: 1,
        AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue
    ]
}

// MARK: - 녹음 권한 부여
extension AudioController {
    public var isRecordPermissionGranted: Bool {
        AVAudioApplication.shared.recordPermission == .granted
    }
    
    public func getRecordPermission() async {
        await AVAudioApplication.requestRecordPermission()
    }
}

// MARK: - 재생 기능 메소드
extension AudioController {
    public func startAudio(recordURL: String) {
        guard let fileURL = URL(string: recordURL) else {
            return
        }
        
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(.playback, mode: .default)
            try session.overrideOutputAudioPort(.speaker)
            
            self.audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
            audioPlayer?.delegate = self
            audioPlayer?.play()
            
            startMonitoring()
            
            self.isPlaying = true
        } catch {
            // TODO: - Error handling
        }
    }
    
    public func stopAudio() {
        self.timer?.invalidate()
        self.audioPlayer?.stop()
        
        stopMonitoring()
        
        self.isPlaying = false
    }
}

// MARK: - 녹음 기능 메소드
extension AudioController {
    public func startRecording(id: UUID) {
        let audioSession = AVAudioSession.sharedInstance()
        
        guard let driveURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appending(path: "Documents") else {
            return
        }
        let fileURL = driveURL.appending(path: "\(id.uuidString).m4a")
        
        do {
            self.audioRecorder = try AVAudioRecorder(url: fileURL, settings: recorderSettings)
            
            try audioSession.setCategory(.record, mode: .default, options: [])
            
            self.audioRecorder?.record()
            startMonitoring()

            self.isRecorded = true
            self.isRecording = true
        } catch {
            // TODO: - Error handling
        }
    }
    
    public func stopRecording() {
        self.timer?.invalidate()
        self.audioRecorder?.stop()
        
        stopMonitoring()
        
        self.isRecording = false
    }
}


// MARK: - Audio Visualization 메소드
extension AudioController {
    private func startMonitoring() {
        if let audioRecorder = self.audioRecorder {
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [self] timer in
                audioRecorder.updateMeters()
                self.soundSamples[self.currentSample] = self.audioRecorder?.averagePower(forChannel: 0) ?? 10
                self.currentSample = (self.currentSample + 1) % self.numberOfSamples
                self.time = audioRecorder.currentTime
            }
        } else {
            if let audioPlayer = self.audioPlayer {
                self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [self] timer in
                    audioPlayer.updateMeters()
                    self.soundSamples[self.currentSample] = self.audioPlayer?.averagePower(forChannel: 0) ?? 10
                    self.currentSample = (self.currentSample + 1) % self.numberOfSamples
                    self.time = audioPlayer.currentTime
                }
            }
        }
    }
    
    private func stopMonitoring() {
        timer?.invalidate()
    }
}


// MARK: - AVAudioPlayer Delegate 패턴 (audio player 끝났을 때)
extension AudioController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        stopAudio()
    }
}
