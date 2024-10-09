//
//  WritingCell.swift
//  FeatureMainDetail
//
//  Created by 김도형 on 6/19/24.
//

import SwiftUI
import DSKit
import Domain

struct NewsCell: View {
    private let news: NewsEntity
    private let isFake: Bool
    
    init(
        news: NewsEntity,
        isFake: Bool = false
    ) {
        self.news = news
        self.isFake = isFake
    }
    
    var body: some View {
        HStack {
            Spacer()
            
            Text(isFake ? news.title : news.content)
                .font(news.font)
                .lineSpacing(8)
                .multilineTextAlignment(.leading)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: isFake ? 1 : 0, z: 0))
        }
        .frame(width: 460)
    }
}

#Preview {
    NewsCell(news: .init(
        id: 0,
        title: "",
        summary: "",
        content: "",
        image: ""
    ))
}
