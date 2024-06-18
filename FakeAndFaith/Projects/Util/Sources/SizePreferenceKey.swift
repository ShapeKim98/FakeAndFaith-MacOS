//
//  SizePreferenceKey.swift
//  Util
//
//  Created by 김도형 on 6/17/24.
//

import SwiftUI

public struct SizePreferenceKey: PreferenceKey {
    public typealias Value = CGSize
    public static var defaultValue: CGSize = .zero

    public static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
