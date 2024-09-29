//
//  MainDetailView.swift
//  FeatureMainDetail
//
//  Created by 김도형 on 6/16/24.
//

import SwiftUI
import ComposableArchitecture
import Perception
import WaterfallGrid
import FeatureEyeDetail
import DSKit
import Domain

public struct MainDetailView: View {
    @Namespace private var heroAnimation
    
    @Perception.Bindable
    private var store: StoreOf<MainDetailFeature>
    
    public init(store: StoreOf<MainDetailFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithPerceptionTracking {
            Group {
                if store.currentPage == .none {
                    VStack {
                        Spacer()
                        
                        buttons
                        
                        Spacer()
                    }
                } else {
                    ScrollView {
                        VStack {
                            buttons
                            
                            if store.currentPage == .hand {
                                HStack(spacing: 24) {
                                    writingTextField
                                    
                                    writingSubmitButton
                                }
                                .padding(.top, 65)
                            }
                            
                            if store.currentPage == .ear {
                                playWritingButton
                            }
                            
                            writingGrid
                            
                            Spacer()
                        }
                    }
                    .padding(.top, 196)
                }
            }
            .fadeAnimation(delay: 0.5)
            .background(.black)
            .overlay {
                if let store = store.scope(state: \.eyeDetail, action: \.eyeDetail) {
                    EyeDetailView(store: store)
                }
            }
            .navigationBar {
                store.send(.backButtonTapped, animation: .smooth(duration: 1.5))
            } aboutButtonAction: {
                store.send(.aboutButtonTapped, animation: .smooth(duration: 1.5))
            } videoButtonAction: {
                store.send(.videoButtonTapped, animation: .smooth(duration: 1.5))
            } noticeView: {
                Group {
                    if store.eyeDetail != nil {
                        eyeDetailNotice
                    } else {
                        NoticeView(title: .constant(store.noticeTitle))
                            .opacity(store.currentPage != .none ? 1 : 0)
                    }
                }
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
        .matchedGeometryEffect(id: "buttons", in: heroAnimation)
    }
    
    @ViewBuilder
    private func button(
        page: MainDetailFeature.Page,
        action: @escaping () -> Void
    ) -> some View {
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
    
    private var eye: some View {
        Image.eyeIcon
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 350)
            .gesture(
                DragGesture()
                    .onChanged({ dragValue in
                        store.send(.eyeDragging(dragValue))
                    })
                    .onEnded({ dragValue in
                        store.send(.eyeDragged)
                    }))
            .offset(x: store.eyeOffsetX, y: store.eyeOffsetY)
    }
    
    private var writingGrid: some View {
        HStack {
            Spacer(minLength: 200)
            
            ZStack(alignment: .top) {
                WaterfallGrid(store.writings) { writing in
                    let isPlayingTTS = store.currentWritingId != nil
                    let isPlaying = store.currentWritingId == writing.id
                    let playingColor: Color = isPlaying ? .main : .main.opacity(0.5)
                    
                    return Button(action: { store.send(.fakeWritingButtonTapped(writing)) }) {
                        WritingCell(writing: writing)
                            .foregroundStyle(isPlayingTTS ? playingColor : .main)
                    }
                    .disabled(store.currentPage != .ear)
                }
                .gridStyle(columns: 3, spacing: 56)
                .scrollOptions(direction: .vertical)
                .padding(.top, 77)
                
                Button {
                    store.send(.truthWritingsTapped, animation: .smooth(duration: 1))
                } label: {
                    WaterfallGrid(store.truth) { writing in
                        WritingCell(writing: writing)
                            .foregroundStyle(.black)
                    }
                    .gridStyle(columns: 3, spacing: 56)
                    .scrollOptions(direction: .vertical)
                    .padding(.top, 65)
                }
                .disabled(store.currentPage != .eye)
                .allowsHitTesting(false)
            }
            .background(alignment: .topLeading) {
                if store.currentPage == .eye {
                    eye
                }
            }
            
            Spacer(minLength: 200)
        }
    }
    
    private var writingTextField: some View {
        TextField("", text: $store.writingContentText.sending(\.writingContentTextChanged))
            .frame(width: 800, height: 40)
            .background {
                Rectangle()
                    .stroke(.main, lineWidth: 2)
            }
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .font(.minionPro.regular.swiftUIFont(size: 20))
            .foregroundStyle(.main)
            .onSubmit {
                store.send(.writingSubmitButtonTapped, animation: .smooth(duration: 1))
            }
    }
    
    private var writingSubmitButton: some View {
        Button {
            store.send(.writingSubmitButtonTapped, animation: .smooth(duration: 1))
        } label: {
            Image.nextIcon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 40)
        }
    }
    
    private var playWritingButton: some View {
        Button {
            store.send(.playButtonTapped)
        } label: {
            Group {
                if store.isPlayingTTSText {
                    Image.pauseIcon
                        .resizable()
                        .frame(width: 40, height: 40)
                } else {
                    Image.playIcon
                        .frame(width: 40, height: 40)
                }
            }
        }
    }
    
    private var eyeDetailNotice: some View {
        HStack {
            Spacer()
            
            Text("진실은 바라보기 불편합니다")
                .font(.minionPro.bold.swiftUIFont(size: 16))
                .foregroundStyle(.main)
                .padding(.vertical, 12)
            
            Spacer()
        }
        .background(.black)
    }
}



#Preview {
    MainDetailView(
        store: .init(initialState: .init(), reducer: {
            MainDetailFeature()
        }))
}
