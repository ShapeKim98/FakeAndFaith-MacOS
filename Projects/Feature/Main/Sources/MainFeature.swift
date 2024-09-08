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
    private var delegateSend: ((Action.Delegate) -> Void)?
    
    public init(delegateSend: ((Action.Delegate) -> Void)? = nil) {
        self.delegateSend = delegateSend
    }
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
    }
    
    public enum Action {
        case enterButtonTapped
        case aboutButtonTapped(ScrollViewProxy)
        public enum Delegate {
            case showMainDetail
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .enterButtonTapped:
                self.delegateSend?(.showMainDetail)
                return .none
            case .aboutButtonTapped(let proxy):
                proxy.scrollTo("about", anchor: .center)
                return .none
            }
        }
    }
}
