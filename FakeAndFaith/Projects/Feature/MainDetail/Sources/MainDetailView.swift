//
//  MainDetailView.swift
//  FeatureMainDetail
//
//  Created by 김도형 on 6/16/24.
//

import SwiftUI
import ComposableArchitecture
import DSKit

public struct MainDetailView: View {
    @Namespace private var heroAnimation
    
    private let store: StoreOf<MainDetailFeature>
    
    public init(store: StoreOf<MainDetailFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithPerceptionTracking {
            ZStack {
                if store.currentPage == .none {
                    VStack {
                        Spacer()
                        
                        buttons
                            .matchedGeometryEffect(id: "buttons", in: heroAnimation)
                        
                        Spacer()
                    }
                } else {
                    ScrollView {
                        VStack {
                            buttons
                                .matchedGeometryEffect(id: "buttons", in: heroAnimation)
                            
                            Spacer()
                        }
                    }
                    .padding(.top, 196)
                }
            }
            .fadeAnimation(delay: 0.5)
            .background(.black)
            .navigationBar {
                store.send(.backButtonTapped, animation: .smooth(duration: 1.5))
            } aboutButtonAction: {
                store.send(.aboutButtonTapped, animation: .smooth(duration: 1.5))
            } videoButtonAction: {
                store.send(.videoButtonTapped, animation: .smooth(duration: 1.5))
            } noticeView: {
                NoticeView(title: .constant(store.noticeTitle))
                    .opacity(store.currentPage != .none ? 1 : 0)
            }
        }
    }
    
    private var buttons: some View {
        HStack(spacing: 96) {
            Spacer()
            
            button(page: .eye) {
                store.send(.eyeButtonTapped, animation: .smooth(duration: 1.5))
            }
            
            button(page: .ear) {
                store.send(.earButtonTapped, animation: .smooth(duration: 1.5))
            }
            
            button(page: .hand) {
                store.send(.handButtonTapped, animation: .smooth(duration: 1.5))
            }
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private func button(
        page: MainDetailFeature.Page,
        action: @escaping () -> Void) -> some View {
            let isSelected = page == store.currentPage
            
            Button(action: action) {
                VStack {
                    Circle()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(.main)
                        .opacity(isSelected ? 1 : 0)
                    
                    Group {
                        switch page {
                        case .eye:
                            Image.eyeSymbol
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        case .ear:
                            Image.earSymbol
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        case .hand:
                            Image.handSymbol
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        case .none:
                            Image.eyeSymbol
                        }
                    }
                    .frame(height: 100)
                    .opacity((isSelected || store.currentPage == .none) ? 1 : 0.2)
                }
            }
        }
}

#Preview {
    MainDetailView(
        store: .init(initialState: .init(), reducer: {
            MainDetailFeature()
        }))
}
