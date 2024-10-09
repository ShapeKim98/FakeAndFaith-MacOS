//
//  TTSProvider.swift
//  CoreKit
//
//  Created by 김도형 on 9/25/24.
//

import Foundation
import AVFoundation
import NaturalLanguage


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
            self.continuation = continuation
            speak(text)
        }
    }
    
    func speak(_ text: String) {
        isHasNext = true
        let utterance = AVSpeechUtterance(string: text)
        // 텍스트의 언어 자동 감지
        let languageCode = detectLanguage(for: text)
        
        // 감지된 언어로 음성 설정
        utterance.voice = AVSpeechSynthesisVoice(language: languageCode)
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
    
    private func detectLanguage(for text: String) -> String {
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(text)
        if let language = recognizer.dominantLanguage {
            return language.rawValue
        }
        // 기본 언어 설정 (예: 영어)
        return "en-US"
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
