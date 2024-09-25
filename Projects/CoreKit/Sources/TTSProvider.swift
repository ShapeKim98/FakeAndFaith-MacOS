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
    
    private var continuation: CheckedContinuation<Void, Never>?
    
    override init () {
        super.init()
        speechSynthesizer.delegate = self
    }
    
    public func play(_ text: String) async {
        await withCheckedContinuation { [weak self] continuation in
            guard let `self` else { return }
            speak(text)
            self.continuation = continuation
        }
    }
    
    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US") // 음성 언어 설정 (예: 영어)
        utterance.rate = 0.5 // 속도 조절 (0.0 ~ 1.0)
        
        speechSynthesizer.speak(utterance)
    }
    
    public func stop() {
        speechSynthesizer.stopSpeaking(at: .immediate)
    }
}

extension TTSProvider: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(
        _ synthesizer: AVSpeechSynthesizer,
        didFinish utterance: AVSpeechUtterance
    ) {
        continuation?.resume(returning: ())
        continuation = nil
    }
}
