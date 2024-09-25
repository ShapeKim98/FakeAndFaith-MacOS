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
        let ttsProvider = TTSProvider.shared
        
        return TTSClient(
            play: { await ttsProvider.play($0) },
            stop: { ttsProvider.stop() }
        )
    }
}

extension DependencyValues {
    public var ttsClient: TTSClient {
        get { self[TTSClient.self] }
        set { self[TTSClient.self] = newValue }
    }
}
