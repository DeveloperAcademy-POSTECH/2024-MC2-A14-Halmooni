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
    
    public var fileURL: URL?
    public var audioLength: TimeInterval?
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
    public func startAudio(filePath: URL?) {
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(.playAndRecord, mode: .default)
            try session.overrideOutputAudioPort(.speaker)
            
            if filePath != nil {
                self.audioPlayer = try AVAudioPlayer(contentsOf: filePath!)
            } else {
                self.audioPlayer = try AVAudioPlayer(contentsOf: self.fileURL!)
            }
            audioPlayer?.delegate = self
            
            audioPlayer?.play()
            
            startMonitoring(isRecord: false)
            
            self.isPlaying = true
            self.audioLength = self.audioPlayer?.duration
            
        } catch {
            // TODO: - Error handling
            print("failed to start audio, \(error.localizedDescription)")
        }
    }
    
    public func stopAudio() {
        self.timer?.invalidate()
        self.audioPlayer?.stop()
        
        stopMonitoring()
        
        self.isPlaying = false
    }
    public func pauseAudio() {
            self.timer?.invalidate()
            self.audioPlayer?.pause()
            
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
            startMonitoring(isRecord: true)

            self.isRecorded = true
            self.isRecording = true
        } catch {
            // TODO: - Error handling
            print("here is problem")
        }
    }
    
    public func stopRecording() {
        self.timer?.invalidate()
        self.fileURL = self.audioRecorder?.url
        self.audioLength = self.audioRecorder?.currentTime
        self.audioRecorder?.stop()
        
        stopMonitoring()
        
        self.isRecording = false
    }
    
    public func resetRecording() {
        self.isRecorded = false
        self.isRecording = false
        self.isPlaying = false
        self.timer = nil
        self.time = nil
        self.audioLength = nil
        
        do {
            guard let url = self.fileURL else {
                return
            }
            
            try FileManager.default.removeItem(at: url)
        } catch {
            // TODO: - 에러 처리
        }
        
        self.fileURL = nil
    }
}


// MARK: - Audio Visualization 메소드
extension AudioController {
    private func startMonitoring(isRecord: Bool) {
        if isRecord {
            audioRecorder?.isMeteringEnabled = true
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [self] timer in
                audioRecorder?.updateMeters()
                self.soundSamples[self.currentSample] = self.audioRecorder?.averagePower(forChannel: 0) ?? 10
                self.currentSample = (self.currentSample + 1) % self.numberOfSamples
                self.time = audioRecorder?.currentTime
            }
        } else {
            audioPlayer?.isMeteringEnabled = true
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [self] timer in
                audioPlayer?.updateMeters()
                self.soundSamples[self.currentSample] = self.audioPlayer?.averagePower(forChannel: 0) ?? 10
                self.currentSample = (self.currentSample + 1) % self.numberOfSamples
                self.time = audioPlayer?.currentTime
            }
        }
    }
    
    private func stopMonitoring() {
        timer?.invalidate()
    }
    
    public func updateCurrentTime(to time: TimeInterval) {
        audioPlayer?.currentTime = time
        }
    public func seek(to time: TimeInterval) {
        if let player = audioPlayer {
            player.currentTime = time
            audioPlayer?.currentTime = time
        }
    }
}


// MARK: - AVAudioPlayer Delegate 패턴 (audio player 끝났을 때)
extension AudioController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        stopAudio()
    }
}

// MARK: - AudioController Error
enum AudioControllerError: Error {
    case startPlayingError
    case startRecordingError
    case resetRecordingError
}
