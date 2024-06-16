//
//  MainDetailFeature.swift
//  FeatureMainDetail
//
//  Created by 김도형 on 6/16/24.
//

import ComposableArchitecture

@Reducer
public struct MainDetailFeature {
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
        var currentPage: Page = .none
        var noticeTitle: String = ""
    }
    
    public enum Action {
        case eyeButtonTapped
        case earButtonTapped
        case handButtonTapped
        case backButtonTapped
        case aboutButtonTapped
        case videoButtonTapped
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
                state.currentPage = .ear
                return .none
            case .handButtonTapped:
                state.noticeTitle = "나의 글을 투고하세요 / 거짓이든 진실이든 글은 업로드 됩니다"
                state.currentPage = .hand
                return .none
            case .backButtonTapped:
                state.noticeTitle = ""
                state.currentPage = .none
                return .none
            case .aboutButtonTapped:
                return .none
            case .videoButtonTapped:
                return .none
            }
        }
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
