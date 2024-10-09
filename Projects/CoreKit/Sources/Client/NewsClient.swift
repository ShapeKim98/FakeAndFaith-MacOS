//
//  NewsClient.swift
//  CoreKit
//
//  Created by 김도형 on 10/9/24.
//

import Foundation

import Dependencies

public struct NewsClient {
    public var fetchEyeNewsList: () -> [NewsData]
    public var fetchEarNewsList: () -> [NewsData]
    public var fetchHandNewsList: () -> [NewsData]
}

extension NewsClient: DependencyKey {
    public static var liveValue: NewsClient {
        return NewsClient(
            fetchEyeNewsList: { NewsDataSource.eyeNews },
            fetchEarNewsList: { NewsDataSource.earNews },
            fetchHandNewsList: { NewsDataSource.handNews }
        )
    }
}

extension DependencyValues {
    public var newsClient: NewsClient {
        get { self[NewsClient.self] }
        set { self[NewsClient.self] = newValue }
    }
}
