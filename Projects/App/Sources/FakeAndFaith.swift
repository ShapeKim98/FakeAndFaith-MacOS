//
//  App.stencil.swift
//  ProjectDescriptionHelpers
//
//  Created by 김도형 on 6/16/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct FakeAndFaithApp: App {
    var body: some Scene {
        WindowGroup {
            // TODO: 루트 뷰 추가
            RootView(store: .init(initialState: .main(.init()), reducer: {
                RootFeature()
            }))
        }
    }
}
