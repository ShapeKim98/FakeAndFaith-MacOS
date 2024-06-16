//
//  App.stencil.swift
//  ProjectDescriptionHelpers
//
//  Created by 김도형 on 6/16/24.
//

import SwiftUI
import ComposableArchitecture
import FeatureMain

@main
struct MainDemoApp: App {
    var body: some Scene {
        WindowGroup {
            // TODO: 루트 뷰 추가
            MainView(store: Store(initialState: MainFeature.State()) {
                MainFeature()
            })
        }
    }
}
