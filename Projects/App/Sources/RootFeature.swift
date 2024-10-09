//
//  RootFeature.swift
//  App
//
//  Created by 김도형 on 6/19/24.
//

import ComposableArchitecture
import FeatureMain
import FeatureEyeDetail
import FeatureMainDetail
import Domain

@Reducer
struct RootFeature {
    init() {}
    
    @ObservableState
    enum State {
        case main(MainFeature.State)
        case mainDetail(MainDetailFeature.State)
    }
    
    enum Action {
        case main(MainFeature.Action)
        case mainDetail(MainDetailFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .main(.delegate(.showMainDetail)):
                state = .mainDetail(.init())
                return .none
            case .mainDetail(.delegate(.showMain)):
                state = .main(.init())
                return .none
            case .main, .mainDetail:
                return .none
            }
        }
        .ifCaseLet(\.main, action: \.main) {
            MainFeature()
        }
        .ifCaseLet(\.mainDetail, action: \.mainDetail) {
            MainDetailFeature()
        }
    }
}

extension RootFeature {
    enum Destination {
        case main
        case mainDetail
    }
}
