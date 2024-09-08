//
//  EyeDetailView.swift
//  FeatureMain
//
//  Created by 김도형 on 6/19/24.
//

import SwiftUI
import ComposableArchitecture
import DSKit

public struct EyeDetailView: View {
    private let store: StoreOf<EyeDetailFeature>
    
    public init(store: StoreOf<EyeDetailFeature>) {
        self.store = store
    }
    
    public var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 36) {
                people
                    .frame(height: proxy.size.height)
                
                Spacer()
                
                title
                
                Spacer()
                
                description
                
//                Text("한글")
//                    .font(.eulyoo1945.semiBold.swiftUIFont(size: 14)) +
//                Text("en")
//                    .font(.minionPro.semibold.swiftUIFont(size: 14))
                
                
                
                Spacer()
                
                closeButton
            }
            .padding(.top, 120)
            .background(.main)
            .ignoresSafeArea()
        }
    }
    
    private var people: some View {
        Image.peopleImage
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    private var title: some View {
        VStack {
            Text("Faith, Religion,\nand the Danger\nof Cults")
                .font(.minionPro.bold.swiftUIFont(size: 60))
                .foregroundStyle(.black)
                .multilineTextAlignment(.leading)
                .padding(.top, 120)
            
            Spacer()
        }
    }
    
    private var description: some View {
        VStack {
            Color.main
            
            
            Spacer()
            
            Text("""
        Faith is a profound and personal aspect of human experience. It is the belief in something greater than oneself, often tied to religious or spiritual convictions. Faith provides comfort and guidance, especially in times of uncertainty and hardship. It can unite people, fostering a sense of community and shared purpose. Faith is not merely about blind belief; it involves trust and confidence in the principles and teachings of one's faith tradition. It is a journey of continual growth, reflection, and understanding. Through faith, individuals find meaning and hope, helping them navigate the complexities of life with a sense of purpose and direction.
        """)
            .font(.minionPro.bold.swiftUIFont(size: 14))
            .foregroundStyle(.black)
            .multilineTextAlignment(.leading)
            .frame(width: 320)
            .padding(.bottom, 140)
        }
    }
    
    private var closeButton: some View {
        VStack {
            Button {
                store.send(.closeButtonTapped)
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
        .padding(.trailing, 100)
    }
}

#Preview {
    EyeDetailView(store: .init(initialState: .init(), reducer: {
        EyeDetailFeature()
    }))
}
