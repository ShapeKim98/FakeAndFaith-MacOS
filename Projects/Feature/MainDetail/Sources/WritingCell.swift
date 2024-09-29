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
    @State private var font = WritingFont.allCases.shuffled()[0].font
    
    private let writing: Writing
    
    init(writing: Writing) {
        self.writing = writing
    }
    
    var body: some View {
        Text(writing.content)
            .font(font)
            .lineSpacing(8)
            .multilineTextAlignment(.leading)
            .frame(width: 460)
    }
}

extension WritingCell {
    enum WritingFont: CaseIterable {
        case blackR01
        case blackR02
        case blackB01
        case blackB02
        case blackB03
        case blackB04
        
        var font: Font {
            switch self {
            case .blackR01:
                return DSKitFontFamily.MinionPro.regular.swiftUIFont(size: 14)
            case .blackR02:
                return DSKitFontFamily.MinionPro.regular.swiftUIFont(size: 24)
            case .blackB01:
                return DSKitFontFamily.MinionPro.bold.swiftUIFont(size: 14)
            case .blackB02:
                return DSKitFontFamily.MinionPro.bold.swiftUIFont(size: 20)
            case .blackB03:
                return DSKitFontFamily.MinionPro.bold.swiftUIFont(size: 24)
            case .blackB04:
                return DSKitFontFamily.MinionPro.bold.swiftUIFont(size: 32)
            }
        }
    }
}

#Preview {
    WritingCell(writing: .init(id: 0, content: ""))
}
