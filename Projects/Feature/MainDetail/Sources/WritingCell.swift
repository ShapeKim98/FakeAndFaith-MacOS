//
//  WritingCell.swift
//  FeatureMainDetail
//
//  Created by 김도형 on 6/19/24.
//

import SwiftUI
import DSKit
import Domain

struct WritingCell: View {
    private let writing: Writing
    private let isFake: Bool
    
    init(
        writing: Writing,
        isFake: Bool = false
    ) {
        self.writing = writing
        self.isFake = isFake
    }
    
    var body: some View {
        HStack {
            Spacer()
            
            Text(writing.content)
                .font(writing.font)
                .lineSpacing(8)
                .multilineTextAlignment(.leading)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: isFake ? 1 : 0, z: 0))
        }
        .frame(width: 460)
    }
}

#Preview {
    WritingCell(writing: .init(id: 0, content: ""))
}
