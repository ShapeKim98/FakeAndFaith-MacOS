//
//  Writing.swift
//  Domain
//
//  Created by 김도형 on 6/18/24.
//

import SwiftUI

import CoreKit
import DSKit

public struct NewsEntity: Identifiable {
    public let id: Int
    public let title: String
    public let truth: String
    public let summary: String
    public let content: String
    public let image: String
    public let font: Font
    
    public init(
        id: Int,
        title: String,
        truth: String,
        summary: String,
        content: String,
        image: String,
        font: Font = WritingFont.allCases.shuffled()[0].font
    ) {
        self.id = id
        self.title = title
        self.truth = truth
        self.summary = summary
        self.content = content
        self.image = image
        self.font = font
    }
}

extension NewsData {
    public func toEntity() -> NewsEntity {
        return .init(
            id: self.id,
            title: self.title,
            truth: self.truth,
            summary: self.summary,
            content: self.content,
            image: self.image
        )
    }
}

extension NewsEntity {
    public enum WritingFont: CaseIterable {
        case blackR01
        case blackR02
        case blackB01
        case blackB02
        case blackB03
        case blackB04
        
        public var font: Font {
            switch self {
            case .blackR01:
                return DSKitFontFamily.Eulyoo1945.regular.swiftUIFont(size: 14)
            case .blackR02:
                return DSKitFontFamily.Eulyoo1945.regular.swiftUIFont(size: 24)
            case .blackB01:
                return DSKitFontFamily.Eulyoo1945.semiBold.swiftUIFont(size: 14)
            case .blackB02:
                return DSKitFontFamily.Eulyoo1945.semiBold.swiftUIFont(size: 20)
            case .blackB03:
                return DSKitFontFamily.Eulyoo1945.semiBold.swiftUIFont(size: 24)
            case .blackB04:
                return DSKitFontFamily.Eulyoo1945.semiBold.swiftUIFont(size: 32)
            }
        }
    }
}
