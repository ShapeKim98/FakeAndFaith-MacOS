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
    @Dependency(\.newsClient)
    private var newsClient
    @Dependency(\.ttsClient)
    private var ttsClient
    @Dependency(\.openURL)
    private var openURL
    
    public init() { }
    
    @ObservableState
    public struct State {
        fileprivate var domain = MainDetail()
        
        var newsList: [NewsEntity] {
            switch currentPage {
            case .eye: return domain.eyeNewsList
            case .ear: return domain.earNewsList
            case .hand: return domain.handNewsList
            case .none: return []
            }
        }
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
        
        public init() { }
    }
    
    public enum Action: BindableAction {
        case eyeButtonTapped
        case earButtonTapped
        case handButtonTapped
        case backButtonTapped
        case aboutButtonTapped
        case videoButtonTapped
        case eyeDragging(DragGesture.Value)
        case updateEyeOffsetX(DragGesture.Value)
        case updateEyeOffsetY(DragGesture.Value)
        case eyeDragged
        case mainDetailViewOnAppeared
        case writingSubmitButtonTapped
        case showEyeDetail(NewsEntity)
        case closeEyeDetail
        case delegate(Delegate)
        case eyeDetail(EyeDetailFeature.Action)
        case playTTS
        case stopTTS
        case playButtonTapped
        case cancelTTSStream
        case updateCurrentWritingId(Int?)
        case fakeWritingButtonTapped(NewsEntity)
        case writingUpdate([NewsEntity])
        case fetchEyeNewsList
        case fetchEarNewsList
        case fetchHandNewsList
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
                guard let url = URL(string: "https://www.youtube.com/watch?v=XNWM_h8i6is") else {
                    return .none
                }
                return .run { _ in
#if os(macOS)
                    NSWorkspace.shared.open(url)
#else
                    await openURL(url)
#endif
                }
            case .eyeDragging(let dragValue):
                state.eyeIsDragging = true
                return .merge(
                    .send(.updateEyeOffsetX(dragValue)),
                    .send(.updateEyeOffsetY(dragValue))
                )
            case .updateEyeOffsetX(let dragValue):
                let moveX = dragValue.translation.width
                state.eyeOffsetX += moveX
                return .none
            case .updateEyeOffsetY(let dragValue):
                let moveY = dragValue.translation.height
                state.eyeOffsetY += moveY
                return .none
            case .eyeDragged:
                state.eyeIsDragging = false
                return .none
            case .mainDetailViewOnAppeared:
                return .merge(
                    .send(.fetchEyeNewsList),
                    .send(.fetchEarNewsList),
                    .send(.fetchHandNewsList)
                )
            case .writingSubmitButtonTapped:
                return updateHandNewsList(state: &state)
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
                if id == nil {
                    state.isPlayingTTSText = false
                }
                state.currentWritingId = id
                return .none
            case let .fakeWritingButtonTapped(writing):
                guard state.currentPage == .ear else {
                    return .send(.showEyeDetail(writing), animation: .smooth)
                }
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
                state.domain.handNewsList = writings
                return .none
            case .fetchEyeNewsList:
                state.domain.eyeNewsList = newsClient.fetchEyeNewsList().map {
                    news in news.toEntity()
                }
                return .none
            case .fetchEarNewsList:
                state.domain.earNewsList = newsClient.fetchEarNewsList().map {
                    news in news.toEntity()
                }
                return .none
            case .fetchHandNewsList:
                state.domain.handNewsList = newsClient.fetchHandNewsList().map {
                    news in news.toEntity()
                }
                return .none
            case .binding:
                return .none
            case .showEyeDetail(let news):
                state.eyeDetail = .init(news: news)
                return .none
            }
        }
        .ifLet(\.eyeDetail, action: \.eyeDetail) {
            EyeDetailFeature()
        }
        ._printChanges()
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
            Task { [ writings = state.domain.earNewsList ] in
                for writing in writings {
                    let isHasNext = await ttsClient.play(writing.content)
                    continuation.yield((isHasNext, writing.id))
                }
                
                continuation.finish()
            }
        }
        return .run { send in
            await send(.updateCurrentWritingId(1), animation: .smooth)
            
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
    
    private func updateHandNewsList(state: inout State) -> Effect<Action> {
        var newWritings = state.domain.handNewsList.map { writing in
            return NewsEntity(
                id: writing.id + 1,
                title: writing.title,
                truth: writing.truth,
                summary: writing.summary,
                content: writing.content,
                image: writing.image,
                font: writing.font
            )
        }
        newWritings.insert(
            NewsEntity(
                id: 1,
                title: state.writingContentText,
                truth: "",
                summary: "",
                content: "",
                image: ""
            ),
            at: 0
        )
        state.writingContentText = ""
        return .send(.writingUpdate(newWritings), animation: .smooth)
    }
}

extension MainDetailFeature {
    enum Page: Equatable {
        case none
        case eye
        case ear
        case hand
    }
}
