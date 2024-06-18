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

@Reducer
struct RootFeature {
    init() {}
    
    @ObservableState
    struct State {
        var destination: Destination = .main
    }
    
    enum Action {
        case showMain
        case showMainDetail
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .showMain:
                state.destination = .main
                return .none
            case .showMainDetail:
                state.destination = .mainDetail
                return .none
            }
        }
    }
}

extension RootFeature {
    enum Destination {
        case main
        case mainDetail
    }
}
