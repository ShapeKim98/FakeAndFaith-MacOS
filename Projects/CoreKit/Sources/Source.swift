//
//  Source.stencil.swift
//  Manifests
//
//  Created by 김도형 on 6/16/24.
//

import AVFoundation

import Dependencies

public struct TTSClient {
    public var play: (_ text: String) async -> Void
    public var stop: () async -> Void
}

extension TTSClient: DependencyKey {
    public static var liveValue: TTSClient {
        let speechSynthesizer = AVSpeechSynthesizer()
        
        return TTSClient(
            play: { text in
                let utterance = AVSpeechUtterance(string: text)
                utterance.voice = AVSpeechSynthesisVoice(language: "en-US") // 음성 언어 설정 (예: 영어)
                utterance.rate = 0.5 // 속도 조절 (0.0 ~ 1.0)
                
                speechSynthesizer.speak(utterance)
            },
            stop: {
                speechSynthesizer.stopSpeaking(at: .immediate)
            }
        )
    }
}

extension DependencyValues {
    public var ttsClient: TTSClient {
        get { self[TTSClient.self] }
        set { self[TTSClient.self] = newValue }
    }
}
