//
//  FadeAnimationModifier.swift
//  DSKit
//
//  Created by 김도형 on 6/16/24.
//

import SwiftUI

struct FadeAnimationModifier: ViewModifier {
    @State private var isVisible = false
    var delay: Double

    func body(content: Content) -> some View {
        content
            .offset(y: isVisible ? 0 : 50)
            .opacity(isVisible ? 1 : 0)
            .onAppear {
                withAnimation(.smooth(duration: 3).delay(delay)) {
                    self.isVisible = true
                }
            }
    }
}

extension FadeAnimationModifier {
    enum Phase: CaseIterable {
      case move
      
      var verticalOffset: Double {
        switch self {
        case .move:
          return 0
        }
      }
    }
}

public extension View {
    func fadeAnimation(delay: Double) -> some View {
        self.modifier(FadeAnimationModifier(delay: delay))
    }
}
