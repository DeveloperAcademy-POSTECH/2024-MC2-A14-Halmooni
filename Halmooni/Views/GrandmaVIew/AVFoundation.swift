//
//  AVFoundation.swift
//  grandmother
//
//  Created by Kyu Im on 5/19/24.
//
//import AVFoundation


import SwiftUI
import AVFoundation

class AudioPlayerViewModel: ObservableObject {
    private var player: AVPlayer?
    private var playerObserver: Any?
    
    @Published var isPlaying = false
    @Published var currentTime: Double = 0.0
    @Published var duration: Double = 0.0
    
    init() {
        if let url = Bundle.main.url(forResource: "audiofile", withExtension: "m4a") {
            player = AVPlayer(url: url)
            duration = player?.currentItem?.asset.duration.seconds ?? 0
            addPeriodicTimeObserver()
        }
    }
    
    func playOrPause() {
        guard let player = player else { return }
        if player.timeControlStatus == .paused {
            player.play()
            isPlaying = true
        } else {
            player.pause()
            isPlaying = false
        }
    }
    
    private func addPeriodicTimeObserver() {
        guard let player = player else { return }
        let interval = CMTime(seconds: 1, preferredTimescale: 2)
        playerObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            self?.currentTime = time.seconds
        }
    }
}
