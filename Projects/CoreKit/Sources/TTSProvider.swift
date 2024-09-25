//
//  TTSProvider.swift
//  CoreKit
//
//  Created by 김도형 on 9/25/24.
//

import Foundation
import AVFoundation


final class TTSProvider: NSObject {
    static let shared = TTSProvider()
    
    private let speechSynthesizer = AVSpeechSynthesizer()
    
    private var continuation: CheckedContinuation<Bool, Never>?
    private var isHasNext = true
    
    override init () {
        super.init()
        speechSynthesizer.delegate = self
    }
    
    public func play(_ text: String) async -> Bool {
        guard isHasNext else { return false }
        return await withCheckedContinuation { [weak self] continuation in
            guard let `self` else { return }
            speak(text)
            self.continuation = continuation
        }
    }
    
    func speak(_ text: String) {
        isHasNext = true
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US") // 음성 언어 설정 (예: 영어)
        utterance.rate = 0.5 // 속도 조절 (0.0 ~ 1.0)
        
        speechSynthesizer.speak(utterance)
    }
    
    public func stop() {
        isHasNext = false
        speechSynthesizer.stopSpeaking(at: .immediate)
    }
    
    public func finished() {
        isHasNext = true
        print(isHasNext)
    }
}

extension TTSProvider: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(
        _ synthesizer: AVSpeechSynthesizer,
        didFinish utterance: AVSpeechUtterance
    ) {
        print(isHasNext)
        continuation?.resume(returning: isHasNext)
        continuation = nil
    }
}
