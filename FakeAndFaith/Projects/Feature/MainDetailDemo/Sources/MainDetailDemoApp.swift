//
//  App.stencil.swift
//  ProjectDescriptionHelpers
//
//  Created by 김도형 on 6/16/24.
//

import SwiftUI
import FeatureMainDetail

@main
struct MainDetailDemoApp: App {
    var body: some Scene {
        WindowGroup {
            // TODO: 루트 뷰 추가
            MainDetailView(
                store: .init(initialState: .init(), reducer: {
                    MainDetailFeature()
                }))
        }
    }
}
