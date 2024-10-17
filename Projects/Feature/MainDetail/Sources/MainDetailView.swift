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
                    content
                }
            }
            .fadeAnimation(delay: 0.5)
            .background(.black)
            .overlay {
                if let store = store.scope(state: \.eyeDetail, action: \.eyeDetail) {
                    EyeDetailView(store: store)
                        .transition(.opacity)
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
            .onAppear {
                store.send(.mainDetailViewOnAppeared)
            }
        }
    }
    
    private var content: some View {
        ScrollView {
            VStack(spacing: 0) {
                buttons
                
                title
                
                if store.currentPage == .hand {
                    HStack(spacing: 24) {
                        writingTextField
                        
                        writingSubmitButton
                    }
                }
                
                if store.currentPage == .ear {
                    playWritingButton
                }
                
                writingGrid
                
                Spacer()
            }
        }
        .padding(.top, 30)
    }
    
    private var title: some View {
        return Group {
            Text(titleText)
                .font(.eulyoo1945.semiBold.swiftUIFont(size: 24))
                .lineSpacing(8)
                .multilineTextAlignment(.center)
                .foregroundStyle(.main)
                .padding(.top, 40)
            
            Spacer(minLength: 100)
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
                    })
            )
            .offset(x: store.eyeOffsetX, y: store.eyeOffsetY)
    }
    
    private var writingGrid: some View {
        WaterfallGrid(store.newsList) { news in
            ZStack(alignment: .topLeading) {
                let isPlayingTTS = store.currentWritingId != nil
                let isPlaying = store.currentWritingId == news.id
                let playingColor: Color = isPlaying ? .main : .main.opacity(0.3)
                
                Button {
                    store.send(
                        .fakeWritingButtonTapped(news),
                        animation: .smooth
                    )
                } label: {
                    NewsCell(
                        news: news,
                        isFake: !isPlaying
                    )
                    .foregroundStyle(isPlayingTTS ? playingColor : .main)
                    .animation(.smooth(duration: 2), value: isPlaying)
                }
                .disabled(store.currentPage == .hand)
                
                if store.currentPage == .eye {
                    NewsCell(news: news)
                        .foregroundStyle(.black)
                        .allowsHitTesting(false)
                }
            }
            .frame(width: 460, alignment: .leading)
            .transition(.opacity)
            .animation(.smooth, value: store.currentPage)
        }
        .gridStyle(
            columns: 3,
            spacing: 56,
            animation: nil
        )
        .scrollOptions(direction: .vertical)
        .padding(.top, 77)
        .background(alignment: .topLeading) {
            if store.currentPage == .eye {
                eye
            }
        }
        .padding(.horizontal, 200)
    }
    
    private var writingTextField: some View {
        TextField(text: $store.writingContentText) {
            Text("글을 작성해주세요")
                .font(.eulyoo1945.semiBold.swiftUIFont(size: 24))
                .foregroundStyle(.main.opacity(0.3))
        }
        .padding(8)
        .background {
            Rectangle()
                .stroke(.main, lineWidth: 2)
        }
        .frame(width: 800, height: 40)
        .autocorrectionDisabled()
        .textInputAutocapitalization(.never)
        .font(.minionPro.regular.swiftUIFont(size: 20))
        .foregroundStyle(.main)
        .onSubmit {
            store.send(.writingSubmitButtonTapped)
        }
    }
    
    private var writingSubmitButton: some View {
        Button {
            store.send(.writingSubmitButtonTapped)
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
                .foregroundStyle(store.isFakeEyeDetail ? .main : .black)
                .padding(.vertical, 12)
            
            Spacer()
        }
        .background(store.isFakeEyeDetail ? .black : .main)
    }
    
    private var titleText: String {
        switch store.currentPage {
        case .eye:
            return "눈을 움직여 진짜 제목을 확인하세요\n기사는 제목을 누르면 확인할 수 있습니다"
        case .ear:
            return "제목을 눌러 기사의 내용을 들어보세요\n진짜 제목은 무엇일까요?"
        case .hand:
            return "우리도 기사를 쓸 수 있습니다\n그러나 디지털 시대에 글은 지워지지 않습니다"
        case .none:
            return ""
        }
    }
}



#Preview {
    MainDetailView(
        store: .init(initialState: .init(), reducer: {
            MainDetailFeature()
        }))
}
