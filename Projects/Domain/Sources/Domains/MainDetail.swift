//
//  MainDetail.swift
//  Domain
//
//  Created by 김도형 on 10/9/24.
//

import Foundation

import ComposableArchitecture

public struct MainDetail {
    public var eyeNewsList: [NewsEntity] = .init()
    public var earNewsList: [NewsEntity] = .init()
    public var handNewsList: [NewsEntity] = .init()
    
    public init() { }
}
