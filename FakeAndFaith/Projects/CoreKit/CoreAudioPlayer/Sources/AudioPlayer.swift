//
//  AudioPlayer.swift
//  CoreAudioPlayer
//
//  Created by 김도형 on 6/19/24.
//

import Foundation
import Combine
import AVFoundation
import Dependencies

public final class AudioPlayer {
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    private var currentIndex: Int = 0
    public var currentIndexSubject: PassthroughSubject<Int, Never> = .init()
    private var audioFiles: [String] = []
    private var cancellables = Set<AnyCancellable>()
    
    public func play(audioFiles: [String]) {
        self.audioFiles = audioFiles
        self.currentIndex = 0
        playCurrentFile()
    }
    
    private func playCurrentFile() {
        guard currentIndex < audioFiles.count else {
            return
        }
        
        let fileName = audioFiles[currentIndex]
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
            print("Failed to find audio file: \(fileName)")
            return
        }
        
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        player?.play()
        
        player?.publisher(for: \.status)
            .sink { [weak self] status in
                if status == .readyToPlay {
                    self?.observePlayerItemDidPlayToEndTime()
                }
            }
            .store(in: &cancellables)
    }
    
    private func observePlayerItemDidPlayToEndTime() {
        NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime, object: playerItem)
            .sink { [weak self] _ in
                guard let `self` else { return }
                
                self.currentIndex += 1
                self.currentIndexSubject.send(self.currentIndex)
                self.playCurrentFile()
            }
            .store(in: &cancellables)
    }
    
    public func stop() {
        player?.pause()
        cancellables.removeAll()
    }
}

extension DependencyValues {
    public var audioPlayer: AudioPlayer {
        get { self[AudioPlayer.self] }
        set { self[AudioPlayer.self] = newValue }
    }
}

extension AudioPlayer: DependencyKey {
    public static var liveValue: AudioPlayer {
        return .init()
    }
    
    public static var previewValue: AudioPlayer {
        return .init()
    }
}
