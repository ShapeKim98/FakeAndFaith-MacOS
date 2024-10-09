//
//  RootView.swift
//  App
//
//  Created by 김도형 on 6/19/24.
//

import SwiftUI
import ComposableArchitecture
import Perception
import FeatureMain
import FeatureEyeDetail
import FeatureMainDetail
import Domain

struct RootView: View {
    private let store: StoreOf<RootFeature>
    
    init(store: StoreOf<RootFeature>) {
        self.store = store
    }
    
    var body: some View {
        WithPerceptionTracking {
            Group {
                switch store.state {
                case .main:
                    if let store = store.scope(state: \.main, action: \.main) {
                        MainView(store: store)
                    }
                case .mainDetail:
                    if let store = store.scope(state: \.mainDetail, action: \.mainDetail) {
                        MainDetailView(store: store)
                    }
                }
            }
        }
    }
}

#Preview {
    RootView(store: .init(initialState: .main(.init()), reducer: {
        RootFeature()
    }))
}
