//
//  AudioPlayer.swift
//  Halmooni
//
//  Created by 추서연 on 5/21/24.
//

import Foundation

import SwiftUI
import Combine
import AVFoundation

class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    let objectWillChange = PassthroughSubject<AudioPlayer, Never>()
    
    @Published var isPlaying = false
    @Published var duration: TimeInterval = 0.0
    @Published var isFinished = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    @Published var currentTime: TimeInterval = 0.0 {
        didSet {
            objectWillChange.send(self)
            playProgress = currentTime / duration
        }
    }
    @Published var playProgress: Double = 0.0
    
    var audioPlayer: AVAudioPlayer!
    var timer: Timer?
    
    func startPlayback(audio: URL) {
        let playbackSession = AVAudioSession.sharedInstance()
        
        do {
            try playbackSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Playing over the device's speakers failed")
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audio)
            audioPlayer.delegate = self
            audioPlayer.play()
            isPlaying = true
            isFinished = false
            duration = audioPlayer.duration
            currentTime = 0.0
            startTimer()
        } catch {
            print("Playback failed.")
        }
    }
    
    func stopPlayback() {
        audioPlayer.stop()
        isPlaying = false
        stopTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.updateCurrentTime()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func updateCurrentTime() {
        if let player = audioPlayer {
            currentTime = player.currentTime
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            isPlaying = false
            isFinished = true
            stopTimer()
        }
    }
}
