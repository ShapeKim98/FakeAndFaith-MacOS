//
//  MainDetailFeature.swift
//  FeatureMainDetail
//
//  Created by 김도형 on 6/16/24.
//

import SwiftUI

import ComposableArchitecture
import FeatureEyeDetail
import Domain
import CoreKit

@Reducer
public struct MainDetailFeature {
    @Dependency(\.writingUseCase)
    var writingUseCase
    @Dependency(\.ttsClient)
    private var ttsClient
    
    public init() { }
    
    @ObservableState
    public struct State {
        var writings: [Writing]
        var truth: [Writing] = Writing.truth
        var currentPage: Page = .none
        var noticeTitle: String = ""
        var eyeOffsetX: CGFloat = 0
        var eyeOffsetY: CGFloat = 0
        var eyeIsDragging: Bool = false
        var writingContentText: String = ""
        var isPlayingTTSText: Bool = false
        var playingTask: Task<Void, Never>?
        var currentWritingId: Int?
        
        @Presents
        var eyeDetail: EyeDetailFeature.State?
        
        public init(writings: [Writing] = []) {
            self.writings = writings
        }
    }
    
    public enum Action: BindableAction {
        case eyeButtonTapped
        case earButtonTapped
        case handButtonTapped
        case backButtonTapped
        case aboutButtonTapped
        case videoButtonTapped
        case eyeDragging(DragGesture.Value)
        case eyeDragged
        case mainDetailViewOnAppeared
        case writingSubmitButtonTapped
        case truthWritingsTapped
        case closeEyeDetail
        case delegate(Delegate)
        case eyeDetail(EyeDetailFeature.Action)
        case playTTS
        case stopTTS
        case playButtonTapped
        case cancelTTSStream
        case updateCurrentWritingId(Int?)
        case fakeWritingButtonTapped(Writing)
        case writingUpdate([Writing])
        case binding(BindingAction<State>)
        
        public enum Delegate {
            case showMain
        }
    }
    
    enum CancelId {
        case ttsPlaying
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .eyeButtonTapped:
                state.noticeTitle = "글을 눌러 새로운 시각을 마주하세요 / 눈을 움직여 진실을 보세요"
                state.currentPage = .eye
                return .none
            case .earButtonTapped:
                state.noticeTitle = "글을 눌러 거짓을 들으세요"
                resetEyeOffset(state: &state)
                state.currentPage = .ear
                return .none
            case .handButtonTapped:
                state.noticeTitle = "나의 글을 투고하세요 / 거짓이든 진실이든 글은 업로드 됩니다"
                resetEyeOffset(state: &state)
                state.currentPage = .hand
                return .none
            case .backButtonTapped:
                guard state.currentPage != .none else {
                    return .send(.delegate(.showMain))
                }
                
                state.noticeTitle = ""
                resetEyeOffset(state: &state)
                state.currentPage = .none
                return .none
            case .aboutButtonTapped:
                return .none
            case .videoButtonTapped:
                return .none
            case .eyeDragging(let dragValue):
                state.eyeIsDragging = true
                
                let moveX = dragValue.translation.width
                let moveY = dragValue.translation.height
                
                state.eyeOffsetX += moveX
                state.eyeOffsetY += moveY
                return .none
            case .eyeDragged:
                state.eyeIsDragging = false
                return .none
            case .mainDetailViewOnAppeared:
                state.writings = self.writingUseCase.fetches()
                return .none
            case .writingSubmitButtonTapped:
                let _ = self.writingUseCase.save(
                    content: state.writingContentText
                )
                
                // TODO: 로컬 데이터 도입 후 삭제
                var newWritings = state.writings.map { writing in
                    return Writing(
                        id: writing.id + 1,
                        content: writing.content,
                        font: writing.font
                    )
                }
                newWritings.insert(
                    .init(
                        id: 0,
                        content: state.writingContentText
                    ),
                    at: 0
                )
                state.writingContentText = ""
                return .send(.writingUpdate(newWritings), animation: .smooth)
            case .truthWritingsTapped:
                state.eyeDetail = .init()
                return .none
            case .closeEyeDetail:
                state.eyeDetail = nil
                return .none
            case .delegate:
                return .none
            case .eyeDetail(.delegate(.close)):
                return .send(.closeEyeDetail)
            case .eyeDetail:
                return .none
            case .playTTS:
                return playTTS(state: &state)
            case .stopTTS:
                state.isPlayingTTSText = false
                ttsClient.stop()
                state.currentWritingId = nil
                return .none
            case .playButtonTapped:
                if state.isPlayingTTSText {
                    return .send(.stopTTS)
                } else {
                    return .send(.playTTS)
                }
            case .cancelTTSStream:
                return .cancel(id: CancelId.ttsPlaying)
            case let .updateCurrentWritingId(id):
                state.currentWritingId = id
                return .none
            case let .fakeWritingButtonTapped(writing):
                guard !state.isPlayingTTSText else {
                    return .none
                }
                state.isPlayingTTSText = true
                return .run { send in
                    await send(.updateCurrentWritingId(writing.id))
                    let _ = await ttsClient.play(writing.content)
                    ttsClient.finished()
                    await send(.updateCurrentWritingId(nil))
                }
                .cancellable(id: CancelId.ttsPlaying, cancelInFlight: true)
            case let .writingUpdate(writings):
                state.writings = writings
                return .none
            case .binding:
                return .none
            }
        }
        .ifLet(\.eyeDetail, action: \.eyeDetail) {
            EyeDetailFeature()
        }
    }
    
    private func resetEyeOffset(state: inout State) {
        state.eyeOffsetX = 0
        state.eyeOffsetY = 0
    }
    
    private func playTTS(state: inout State) -> Effect<Action> {
        guard !state.isPlayingTTSText else {
            return .none
        }
        state.isPlayingTTSText = true
        let stream = AsyncStream<(Bool, Int)> { continuation in
            Task { [ writings = state.writings ] in
                for writing in writings {
                    let isHasNext = await ttsClient.play(writing.content)
                    continuation.yield((isHasNext, writing.id))
                }
                
                continuation.finish()
            }
        }
        
        return .run { send in
            await send(.updateCurrentWritingId(0), animation: .smooth)
            
            for await play in stream {
                let (isHasNext, id) = play
                guard isHasNext else {
                    await send(.cancelTTSStream)
                    break
                }
                await send(.updateCurrentWritingId(id + 1), animation: .smooth)
            }
            
            ttsClient.finished()
            await send(.updateCurrentWritingId(nil), animation: .smooth)
        }
        .cancellable(id: CancelId.ttsPlaying, cancelInFlight: true)
    }
}

extension MainDetailFeature {
    enum Page {
        case none
        case eye
        case ear
        case hand
    }
}
