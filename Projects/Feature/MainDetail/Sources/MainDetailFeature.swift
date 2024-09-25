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
        var truth: [Writing] = Writing.truth.shuffled()
        var currentPage: Page = .none
        var noticeTitle: String = ""
        var eyeOffsetX: CGFloat = 0
        var eyeOffsetY: CGFloat = 0
        var eyeIsDragging: Bool = false
        var writingContentText: String = ""
        
        @Presents
        var eyeDetail: EyeDetailFeature.State?
        
        public init(writings: [Writing] = []) {
            self.writings = writings
        }
    }
    
    public enum Action {
        case eyeButtonTapped
        case earButtonTapped
        case handButtonTapped
        case backButtonTapped
        case aboutButtonTapped
        case videoButtonTapped
        case eyeDragging(DragGesture.Value)
        case eyeDragged
        case mainDetailViewOnAppeared
        case writingContentTextChanged(String)
        case writingSubmitButtonTapped
        case truthWritingsTapped
        case closeEyeDetail
        case delegate(Delegate)
        case eyeDetail(EyeDetailFeature.Action)
        
        public enum Delegate {
            case showMain
        }
    }
    
    public var body: some ReducerOf<Self> {
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
                    content: state.writingContentText)
                
                // TODO: 로컬 데이터 도입 후 삭제
                state.writings.append(.init(content: state.writingContentText))
                
                state.writingContentText = ""
                return .none
            case .writingContentTextChanged(let text):
                state.writingContentText = text
                return .none
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
}

extension MainDetailFeature {
    enum Page {
        case none
        case eye
        case ear
        case hand
    }
}
