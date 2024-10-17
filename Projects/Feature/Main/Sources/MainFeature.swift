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
    @Dependency(\.openURL)
    private var openURL
    
    public init() { }
    
    @ObservableState
    public struct State {
        var scrollViewProxy: ScrollViewProxy?
        public init() {}
    }
    
    public enum Action {
        case onAppear(ScrollViewProxy)
        case enterButtonTapped
        case aboutButtonTapped
        case videoButtonTapped
        case eyeImageButtonTapped
        case earImageButtonTapped
        case handImageButtonTapped
        case delegate(Delegate)
        
        case scrollToAbout
        public enum Delegate {
            case showMainDetail
            case aboutButtonTapped
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear(let proxy):
                state.scrollViewProxy = proxy
                return .none
            case .enterButtonTapped:
                return .send(.delegate(.showMainDetail))
            case .aboutButtonTapped:
                return .send(.scrollToAbout)
            case .videoButtonTapped:
                return onOpenURL("https://www.youtube.com/watch?v=XNWM_h8i6is")
            case .eyeImageButtonTapped:
                return onOpenURL("https://vimeo.com/1014847027")
            case .earImageButtonTapped:
                return onOpenURL("https://vimeo.com/1014850697")
            case .handImageButtonTapped:
                return onOpenURL("https://vimeo.com/1014849097")
            case .delegate(.aboutButtonTapped):
                return .run { send in
                    try await Task.sleep(for: .seconds(3.5))
                    await send(.scrollToAbout, animation: .default)
                }
            case .delegate:
                return .none
            case .scrollToAbout:
                state.scrollViewProxy?.scrollTo("about", anchor: .top)
                return .none
            }
        }
    }
    
    private func onOpenURL(_ url: String) -> Effect<Action> {
        guard let url = URL(string: url) else {
            return .none
        }
        return .run { _ in
#if os(macOS)
            NSWorkspace.shared.open(url)
#else
            await openURL(url)
#endif
        }
    }
}
