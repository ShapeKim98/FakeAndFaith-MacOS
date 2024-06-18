//
//  EyeDetailFeature.swift
//  FeatureEyeDetail
//
//  Created by 김도형 on 6/19/24.
//

import ComposableArchitecture

@Reducer
public struct EyeDetailFeature {
    private let delegateSend: ((Action.Delegate) -> Void)?
    
    public init(delegateSend: ((Action.Delegate) -> Void)? = nil) {
        self.delegateSend = delegateSend
    }
    
    @ObservableState
    public struct State {
        public init() {}
    }
    
    public enum Action {
        case closeButtonTapped
        public enum Delegate {
        case close
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .closeButtonTapped:
                self.delegateSend?(.close)
                return .none
            }
        }
    }
}
