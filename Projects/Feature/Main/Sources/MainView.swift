//
//  MainView.swift
//  FeatureMain
//
//  Created by 김도형 on 6/16/24.
//

import SwiftUI
import ComposableArchitecture
import DSKit
import Util

public struct MainView: View {
    @Environment(\.device)
    private var device
    
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
                .font(.eulyoo1945.semiBold.swiftUIFont(size: device.isPhone ? 10 : 24))
                .foregroundStyle(.main)
                .multilineTextAlignment(.leading)
                .lineSpacing(8)
            
            if device.isPhone {
                Spacer()
            } else {
                Spacer(minLength: 210)
            }
            
            if !device.isPhone {
                Image.logo
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 779)
            }
            
            if device.isPhone {
                Spacer()
            } else {
                Spacer(minLength: 210)
            }
            
            Text("신앙심\n인터렉션 웹사이트")
                .font(.eulyoo1945.semiBold.swiftUIFont(size: device.isPhone ? 10 : 24))
                .foregroundStyle(.main)
                .multilineTextAlignment(.trailing)
                .lineSpacing(8)
        
        }
        .padding(.horizontal, device.isPhone ? 20 : 100)
        .overlay() {
            if device.isPhone {
                Image.logo
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150)
            }
        }
        .padding(.top, device.isPhone ? 200 : 240)
        
    }
    
    private var enterButton: some View {
        Button {
            store.send(.enterButtonTapped)
        } label: {
            HStack(spacing: 12) {
                Text("체험하러 가기")
                    .font(.eulyoo1945.semiBold.swiftUIFont(size: device.isPhone ? 14 : 32))
                    .foregroundStyle(.black)
                    .frame(height: device.isPhone ? 35 : nil)
                
                Image.arrowRightIcon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: device.isPhone ? 24 : 72)
            }
            .padding(.vertical, device.isPhone ? 8 : 24)
            .padding(.horizontal, device.isPhone ? 20 : 36)
            .background {
                RoundedRectangle(cornerRadius: 53, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.main)
            }
        }
        .padding(.top, device.isPhone ? 72 : 104)
        .padding(.bottom, device.isPhone ? 0 : 40)
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
                endPoint: .bottom
            )
            .frame(height: device.isPhone ? 200 : 400)
            
            HStack {
                Spacer()
                
                VStack(spacing: device.isPhone ? 42 : 48) {
                    Text("ABOUT")
                        .font(.minionPro.bold.swiftUIFont(size: device.isPhone ? 10 : 24))
                    
                    Text("FAKE and FAITH")
                        .font(.minionPro.bold.swiftUIFont(size: device.isPhone ? 32 : 64))
                }
                .foregroundStyle(.black)
                
                Spacer()
            }
            .padding(.top, device.isPhone ? 32 : 198)
            .padding(.bottom, device.isPhone ? 100 : 260)
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
            
            Text(!device.isPhone
            ? """
            디지털 시대에 가짜뉴스를 식별하고 대응하는 능력은 매우 중요한 기술이 되었습\n니다. 가짜뉴스에 대한 분별력과 수용 반응을 테스트하기 위해 특별한 디지털 행\n사를 개최하였습니다. 신:앙심은 참가자들에게 실시간으로 가짜뉴스를 식별하고\n 그에 대한 반응을 측정하는 기회를 제공합니다. 따라서 개인별로 자신의 확증편향\n 정도를 파악할 수 있고,  이에 대한 경각심을 가질 수 있도록 도와줍니다.
            """
            : """
            디지털 시대에 가짜뉴스를 식별하고 대응하는 능력은 매우 중요한 기술이 되었습니다. 가짜뉴스에 대한 분별력과 수용 반응을 테스트하기 위해 특별한 디지털 행사를 개최하였습니다. 신:앙심은 참가자들에게 실시간으로 가짜뉴스를 식별하고 그에 대한 반응을 측정하는 기회를 제공합니다. 따라서 개인별로 자신의 확증편향 정도를 파악할 수 있고,  이에 대한 경각심을 가질 수 있도록 도와줍니다.
            """
            )
            .font(.eulyoo1945.regular.swiftUIFont(size: device.isPhone ? 12 : 16))
            .foregroundStyle(.main)
            .multilineTextAlignment(.center)
            .lineSpacing(8)
            
            Spacer()
        }
        .padding(.vertical, device.isPhone ? 100 : 204)
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
                if !device.isPhone {
                    Spacer(minLength: 280)
                }
                
                HStack {
                    Spacer()
                    
                    Text(title)
                        .font(.eulyoo1945.semiBold.swiftUIFont(size: device.isPhone ? 10 : 24))
                    
                    Spacer()
                }
                .foregroundStyle(titleColor)
                .padding(.top, device.isPhone ? 84 : 0)
                
                if device.isPhone {
                    Spacer()
                } else {
                    Spacer(minLength: 580)
                }
                
                HStack {
                    Spacer()
                    
                    if device.isPhone {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50)
                    } else {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(minHeight: 200, maxHeight: 261)
                    }
                    
                    Spacer()
                }
                .padding(.bottom, device.isPhone ? 40 : 0)
                
                if !device.isPhone {
                    Spacer(minLength: 180)
                }
            }
        }
    }
}

#Preview {
    MainView(store: Store(initialState: MainFeature.State()) {
        MainFeature()
    })
}
