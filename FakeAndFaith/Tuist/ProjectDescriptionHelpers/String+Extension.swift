//
//  String+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by 김도형 on 6/12/24.
//

import ProjectDescription

public extension String {
    static let appBundleId = "com.FAKEandFAITH"
    
    static func moduleBundleId(name: String) -> String {
        return "\(Self.appBundleId).\(name)"
    }
}
