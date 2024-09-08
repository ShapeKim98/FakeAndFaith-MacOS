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
    public init() { }
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
    }
    
    public enum Action {
        case enterButtonTapped
        case aboutButtonTapped(ScrollViewProxy)
        case delegate(Delegate)
        public enum Delegate {
            case showMainDetail
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .enterButtonTapped:
                return .send(.delegate(.showMainDetail))
            case .aboutButtonTapped(let proxy):
                proxy.scrollTo("about", anchor: .center)
                return .none
            case .delegate:
                return .none
            }
        }
    }
}
