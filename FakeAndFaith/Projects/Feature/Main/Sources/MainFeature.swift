//
//  MainFeature.swift
//  FeatureMain
//
//  Created by 김도형 on 6/16/24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
public struct MainFeature {
    public init() {}
    
    @ObservableState
    public struct State {
        public init() {}
    }
    
    public enum Action {
        case enterButtonTapped
        case aboutButtonTapped(ScrollViewProxy)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .enterButtonTapped:
                return .none
            case .aboutButtonTapped(let proxy):
                proxy.scrollTo("about", anchor: .center)
                return .none
            }
        }
    }
}
