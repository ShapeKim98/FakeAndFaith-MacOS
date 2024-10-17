//
//  MainView.swift
//  FeatureMain
//
//  Created by 김도형 on 6/16/24.
//

import SwiftUI
import ComposableArchitecture
import DSKit

public struct MainView: View {
    private let store: StoreOf<MainFeature>
    
    public init(store: StoreOf<MainFeature>) {
        self.store = store
    }
    
    public var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 0) {
                    title
                        .fadeAnimation(delay: 0.5)
                    
                    enterButton
                        .fadeAnimation(delay: 1.5)
                    
                    about
                        .fadeAnimation(delay: 2.5)
                    
                    description
                        .fadeAnimation(delay: 3.5)
                    
                    images
                        .fadeAnimation(delay: 4.5)
                }
            }
            .background(.black)
            .navigationBar {
                store.send(.aboutButtonTapped, animation: .default)
            } videoButtonAction: {
                store.send(.videoButtonTapped)
            } noticeView: {
                EmptyView()
            }
            .onAppear { store.send(.onAppear(proxy)) }
        }
    }
    
    private var title: some View {
        HStack(spacing: 0) {
            Text("2024.10.24\n- 10.31")
                .font(.eulyoo1945.semiBold.swiftUIFont(size: 24))
                .foregroundStyle(.main)
                .multilineTextAlignment(.leading)
                .lineSpacing(8)
            
            Spacer(minLength: 210)
            
            Image.logo
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 779)
            
            Spacer(minLength: 210)
            
            Text("신앙심\n인터렉션 웹사이트")
                .font(.eulyoo1945.semiBold.swiftUIFont(size: 24))
                .foregroundStyle(.main)
                .multilineTextAlignment(.trailing)
                .lineSpacing(8)
        
        }
        .padding(.horizontal, 100)
        .padding(.top, 240)
    }
    
    private var enterButton: some View {
        Button {
            store.send(.enterButtonTapped)
        } label: {
            HStack(spacing: 12) {
                Text("체험하러 가기")
                    .font(.eulyoo1945.semiBold.swiftUIFont(size: 32))
                    .foregroundStyle(.black)
                
                Image.arrowRightIcon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 72)
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 36)
            .background {
                RoundedRectangle(cornerRadius: 53, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.main)
            }
        }
        .padding(.top, 104)
        .padding(.bottom, 40)
    }
    
    private var about: some View {
        VStack(spacing: 0) {
            LinearGradient(
                gradient: Gradient(
                    colors: [
                        Color(
                            red: 0,
                            green: 0,
                            blue: 0).opacity(0),
                        Color(
                            red: 0.90,
                            green: 0.99,
                            blue: 0.32)
                    ]),
                startPoint: .top,
                endPoint: .bottom)
            .frame(height: 400)
            
            HStack {
                Spacer()
                
                VStack(spacing: 48) {
                    Text("ABOUT")
                        .font(.minionPro.bold.swiftUIFont(size: 24))
                    
                    Text("FAKE and FAITH")
                        .font(.minionPro.bold.swiftUIFont(size: 64))
                }
                .foregroundStyle(.black)
                
                Spacer()
            }
            .padding(.top, 198)
            .padding(.bottom, 260)
            .background {
                Rectangle()
                    .foregroundStyle(.main)
            }
            .id("about")
        }
    }
    
    private var description: some View {
        HStack {
            Spacer()
            
            Text("""
디지털 시대에 가짜뉴스를 식별하고 대응하는 능력은 매우 중요한 기술이 되었습\n니다. 가짜뉴스에 대한 분별력과 수용 반응을 테스트하기 위해 특별한 디지털 행\n사를 개최하였습니다. 신:앙심은 참가자들에게 실시간으로 가짜뉴스를 식별하고\n 그에 대한 반응을 측정하는 기회를 제공합니다. 따라서 개인별로 자신의 확증편향\n 정도를 파악할 수 있고,  이에 대한 경각심을 가질 수 있도록 도와줍니다.
""")
            .font(.eulyoo1945.regular.swiftUIFont(size: 16))
            .foregroundStyle(.main)
            .multilineTextAlignment(.center)
            .lineSpacing(8)
            
            Spacer()
        }
        .padding(.vertical, 204)
    }
    
    private var images: some View {
        Image.eyeEarHandImage
            .resizable()
            .aspectRatio(contentMode: .fit)
            .overlay {
                HStack {
                    imageTitle(
                        title: "진실을 보는 눈",
                        titleColor: .black,
                        image: .eyeSymbol,
                        action: { store.send(.eyeImageButtonTapped) }
                    )
                    
                    imageTitle(
                        title: "거짓을 듣는 귀",
                        titleColor: .white,
                        image: .earSymbol,
                        action: { store.send(.earImageButtonTapped) }
                    )
                    
                    imageTitle(
                        title: "앙심을 품은 손",
                        titleColor: .white,
                        image: .handSymbol,
                        action: { store.send(.handImageButtonTapped) }
                    )
                }
            }
    }
    
    @ViewBuilder
    private func imageTitle(
        title: String,
        titleColor: Color,
        image: Image,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            VStack {
                Spacer(minLength: 280)
                
                HStack {
                    Spacer()
                    
                    Text(title)
                        .font(.eulyoo1945.semiBold.swiftUIFont(size: 24))
                    
                    Spacer()
                }
                .foregroundStyle(titleColor)
                
                Spacer(minLength: 580)
                
                HStack {
                    Spacer()
                    
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minHeight: 200, maxHeight: 261)
                    
                    Spacer()
                }
                
                Spacer(minLength: 180)
            }
        }
    }
}

#Preview {
    MainView(store: Store(initialState: MainFeature.State()) {
        MainFeature()
    })
}
