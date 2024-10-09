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
        
        public init(news:  NewsEntity) {
            self.news = news
        }
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
                return .send(.delegate(.close), animation: .smooth)
            case .delegate:
                return .none
                
            }
        }
    }
}
