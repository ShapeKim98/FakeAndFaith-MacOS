//
//  NewFeedFeature.swift
//  FeatureNewsFeed
//
//  Created by 김도형 on 9/29/24.
//

import SwiftUI
import WebKit

import ComposableArchitecture

@Reducer
public struct NewFeedFeature {
    public init() { }
    
    @ObservableState
    public struct State: Equatable {
        var canGoBack: Bool = false
        var canGoForward: Bool = false
        
        public init() { }
    }
    
    public enum Action: BindableAction {
        case updateNavigationState(canGoBack: Bool, canGoForward: Bool)
        case binding(BindingAction<State>)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .updateNavigationState(canGoBack, canGoForward):
                state.canGoBack = canGoBack
                state.canGoForward = canGoForward
                return .none
            case .binding:
                return .none
            }
        }
    }
}


