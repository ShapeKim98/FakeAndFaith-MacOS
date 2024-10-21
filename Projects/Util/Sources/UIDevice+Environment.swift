//
//  UIDevice+Environment.swift
//  Util
//
//  Created by 김도형 on 10/21/24.
//

import SwiftUI

public struct DeviceProvider {
    private let device = UIDevice.current.userInterfaceIdiom
    
    public var isPhone: Bool { device == .phone }
    
    public init() { }
}

extension DeviceProvider: EnvironmentKey {
    public static let defaultValue = DeviceProvider()
}

extension EnvironmentValues {
    public var device: DeviceProvider {
        get { self[DeviceProvider.self] }
        set { self[DeviceProvider.self] = newValue }
    }
}
