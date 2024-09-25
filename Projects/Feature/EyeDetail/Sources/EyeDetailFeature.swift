//
//  EyeDetailFeature.swift
//  FeatureEyeDetail
//
//  Created by 김도형 on 6/19/24.
//

import ComposableArchitecture

@Reducer
public struct EyeDetailFeature {
    public init() { }
    
    @ObservableState
    public struct State {
        public init() {}
    }
    
    public enum Action {
        case closeButtonTapped
        case delegate(Delegate)
        public enum Delegate {
            case close
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .closeButtonTapped:
                return .send(.delegate(.close))
            case .delegate:
                return .none
                
            }
        }
    }
}
