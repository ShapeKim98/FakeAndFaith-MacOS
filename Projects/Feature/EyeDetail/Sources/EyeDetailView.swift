//
//  EyeDetailView.swift
//  FeatureMain
//
//  Created by 김도형 on 6/19/24.
//

import SwiftUI
import ComposableArchitecture
import Domain
import DSKit

public struct EyeDetailView: View {
    private let store: StoreOf<EyeDetailFeature>
    
    public init(store: StoreOf<EyeDetailFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithPerceptionTracking {
            GeometryReader { proxy in
                let width = proxy.frame(in: .global).width
                
                HStack(spacing: 0) {
                    people
                        .frame(width: width * 0.4)
                        .clipped()
                        .padding(.trailing, width / 24)
                    
                    title
                        .padding(.trailing, width / 34)
                    
                    description
                        .padding(.trailing, width / 27)
                    
                    Spacer()
                    
                    closeButton
                        .padding(.trailing, width / 15)
                }
                .background(.main)
                .ignoresSafeArea()
            }
        }
    }
    
    private var people: some View {
        Image.news(store.news.image)
            .resizable()
            .scaledToFill()
    }
    
    private var title: some View {
        VStack {
            Text(store.news.title)
                .font(.eulyoo1945.semiBold.swiftUIFont(size: 52))
                .foregroundStyle(.black)
                .multilineTextAlignment(.leading)
                .padding(.top, 120)
                .coordinateSpace(name: "title")
            
            Spacer()
        }
    }
    
    private var description: some View {
        GeometryReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack {
                    Text(store.news.content)
                        .font(.eulyoo1945.regular.swiftUIFont(size: 16))
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                }
                .padding(.top, proxy.frame(in: .global).height / 2)
                .padding(.bottom, 150)
            }
        }
    }
    
    private var closeButton: some View {
        VStack {
            Button {
                store.send(.closeButtonTapped, animation: .smooth)
            } label: {
                Image.xIcon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.black)
            }
            
            Spacer()
        }
        .padding(.top, 60)
    }
}

#Preview {
    EyeDetailView(store: .init(
        initialState: .init(news: .init(
            id: 1,
            title: "서울시, 주택 공급 확대를 위한 새로운 대책 마련해...",
            truth: "서울시, 주택 공급 확대 발표 속 세금 인상 논란… 시민들 우려 커져",
            summary: "주택 공급 늘리기 위한 방법 마련",
            content: """
            서울시가 최근 신규 주택 공급을 대폭 확대하겠다고 발표했다. 이는 주택 부족 문제를 해결하기 위한 조치로, 청년층과 중산층의 주거 안정을 목표로 하고 있다. 하지만 이와 함께 세금 인상 계획이 포함되어 있어 시민들의 우려가 커지고 있다.
               
            서울시는 3만 가구를 추가로 공급할 예정이며, 이를 통해 주택 시장의 안정화를 도모할 계획이다. 그러나 이번 주택 공급 확대와 함께 발표된 세금 인상 방안이 많은 논란을 일으키고 있다. 특히, 부동산 관련 세금이 인상될 것으로 알려지면서 시민들은 복잡한 마음을 감추지 못하고 있다.
               
            서울시는 세금 인상이 주택 공급 확대의 재원 확보를 위한 불가피한 선택이었다고 설명하고 있다. 그러나 시민들은 주택 공급이 늘어도 세금 부담이 커지면 실질적인 혜택을 누리기 어려울 것이라는 우려를 하고 있다. 한 시민은 "주택 공급은 반가운 소식이지만, 세금이 오르면 결국 가계 부담이 더 커질 것"이라고 말했다.
               
            전문가들은 세금 인상이 부동산 시장에 미칠 영향에 대해 경고하고 있다. "주택 공급이 늘어난다고 해도 세금 부담이 증가하면 중산층이 더 큰 압박을 받을 것"이라며, 장기적인 주거 안정에 부정적인 영향을 미칠 수 있다고 지적했다.
               
            서울시는 난방비와 생활비 상승 등으로 어려움을 겪고 있는 시민들에게 실질적인 지원책을 마련할 것을 약속하고 있으나, 구체적인 대책은 아직 발표되지 않았다. 시민들은 세금 인상과 관련해 어떤 지원이 있을지 주목하고 있다.
               
            이번 발표로 인해 서울시는 시민들과의 소통이 더욱 중요해질 전망이다. 시민들은 주택 공급 확대와 세금 인상이 어떻게 균형을 이루어야 하는지에 대한 논의가 필요하다고 강조하고 있다. 서울시는 앞으로도 주택 공급 확대와 시민들의 부담을 줄이기 위한 노력을 병행하겠다고 밝혔다.
               
            결국 서울시의 주택 공급 확대 계획은 긍정적인 면도 있지만, 세금 인상이라는 부담이 시민들에게 큰 영향을 미칠 수 있다는 점에서 많은 이들의 우려를 사고 있다. 앞으로의 정책 방향과 시민들의 반응이 주목되는 상황이다.
            """,
            image: "news1"
        )),
        reducer: {
            EyeDetailFeature()
        }
    ))
}
