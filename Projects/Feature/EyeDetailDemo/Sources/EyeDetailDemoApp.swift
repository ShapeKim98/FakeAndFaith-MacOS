//
//  App.stencil.swift
//  ProjectDescriptionHelpers
//
//  Created by 김도형 on 6/16/24.
//

import SwiftUI
import FeatureEyeDetail

@main
struct EyeDetailDemoApp: App {
    var body: some Scene {
        WindowGroup {
            // TODO: 루트 뷰 추가
            EyeDetailView(store: .init(initialState: .init(), reducer: {
                EyeDetailFeature()
            }))
        }
    }
}
