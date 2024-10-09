//
//  WritingData.swift
//  CoreKit
//
//  Created by 김도형 on 10/9/24.
//

import Foundation

public struct NewsData {
    public let id: Int
    public let title: String
    public let summary: String
    public let content: String
    public let image: String
    
    init(
        id: Int,
        title: String,
        summary: String,
        content: String,
        image: String
    ) {
        self.id = id
        self.title = title
        self.summary = summary
        self.content = content
        self.image = image
    }
}
