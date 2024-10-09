//
//  NoticeView.swift
//  FeatureMainDetail
//
//  Created by 김도형 on 6/17/24.
//

import SwiftUI
import DSKit
import Util
import Perception

struct NoticeView: View {
    @Binding var title: String
    
    @State private var xOffset: CGFloat = 0
    @State private var textSize: CGFloat = 0
    
    init(title: Binding<String>) {
        self._title = title
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                Text("\(title) / ")
                    .frame(alignment: .center)
                    .background {
                        GeometryReader { geometry in
                            Color.clear
                                .preference(key: SizePreferenceKey.self, value: geometry.size)
                        }
                    }
                    .onPreferenceChange(SizePreferenceKey.self) { size in
                        self.textSize = size.width
                    }
                
                Text("\(title) / ")
                
                Text("\(title) / ")
                
                Text("\(title) / ")
                
                Text("\(title) / ")
                
                Text("\(title) / ")
                
                Text("\(title) / ")
                
                Text("\(title) / ")
                
                Text("\(title) / ")
                
                Text("\(title) / ")
                
                Text("\(title) / ")
                
                Text("\(title) / ")
                
                Text("\(title) / ")
                
                Text("\(title) / ")
                
                Text("\(title) / ")
                
                Text("\(title) / ")
                
                Text("\(title) / ")
                
                Text("\(title) / ")
                
                Text("\(title) / ")
                
                Text("\(title) / ")
                
                Text("\(title) / ")
                
                Text("\(title) / ")
                
                Text("\(title) / ")
                
                Text("\(title) / ")
            }
            .font(.minionPro.bold.swiftUIFont(size: 16))
            .foregroundStyle(.black)
            .padding(.vertical, 12)
            .offset(x: xOffset)
        }
        .background(.main)
        .disabled(true)
        .onAppear {
            withAnimation(.linear(duration: 14).repeatForever(autoreverses: false)) {
                xOffset = -textSize * 8
            }
        }
        .onChange(of: title) { newValue in
            xOffset = 0
            withAnimation(.linear(duration: 14).repeatForever(autoreverses: false)) {
                xOffset = -textSize * 8
            }
        }
    }
}

#Preview {
    NoticeView(title: .constant("글을 눌러 새로운 시각을 마주하세요 / 눈을 움직여 진실을 보세요"))
        .background(.black)
}
