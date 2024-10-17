//
//  EyeDetailFeature.swift
//  FeatureEyeDetail
//
//  Created by 김도형 on 6/19/24.
//

import ComposableArchitecture
import Domain

@Reducer
public struct EyeDetailFeature {
    public init() { }
    
    @ObservableState
    public struct State {
        var news: NewsEntity
        var isFake: Bool = true
        
        public init(news:  NewsEntity) {
            self.news = news
        }
    }
    
    public enum Action {
        case closeButtonTapped
        case fakeToggleButtonTapped
        case delegate(Delegate)
        public enum Delegate {
            case close
            case fakeToggleButtonTapped(Bool)
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .closeButtonTapped:
                return .send(.delegate(.close), animation: .smooth)
            case .fakeToggleButtonTapped:
                state.isFake.toggle()
                return .send(
                    .delegate(.fakeToggleButtonTapped(state.isFake)),
                    animation: .smooth(duration: 1.5)
                )
            case .delegate:
                return .none
                
            }
        }
    }
}
