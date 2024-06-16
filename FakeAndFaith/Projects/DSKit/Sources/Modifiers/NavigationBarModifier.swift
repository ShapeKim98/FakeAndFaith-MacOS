//
//  NavigationBarModifier.swift
//  DSKit
//
//  Created by 김도형 on 6/16/24.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
    private var backButtonAction: (() -> Void)?
    private var aboutButtonAction: (() -> Void)?
    private var videoButtonAction: (() -> Void)?
    
    init(
        backButtonAction: (() -> Void)? = nil,
        aboutButtonAction: (() -> Void)?,
        videoButtonAction: (() -> Void)?) {
        self.backButtonAction = backButtonAction
        self.aboutButtonAction = aboutButtonAction
        self.videoButtonAction = videoButtonAction
    }
    
    func body(content: Content) -> some View {
        content
            .ignoresSafeArea()
            .overlay(alignment: .top) {
                HStack {
                    Spacer()
                    
                    title
                    
                    Spacer()
                }
                .overlay {
                    HStack(spacing: 30) {
                        if (backButtonAction != nil) {
                            backButton
                        }
                        
                        Spacer()
                        
                        aboutButton
                        
                        videoButton
                    }
                }
                .padding(.horizontal, 52)
                .padding(.vertical, 28)
                .foregroundStyle(.white)
                .background(alignment: .bottom) {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.main)
                }
                .background(.black)
            }
    }
    
    private var backButton: some View {
        Button {
            backButtonAction?()
        } label: {
            Text("BACK")
                .font(.minionPro.bold.swiftUIFont(size: 16))
        }
    }
    
    private var title: some View {
        Text("FAKE and FAITH")
            .font(.minionPro.bold.swiftUIFont(size: 36))
    }
    
    private var aboutButton: some View {
        Button {
            aboutButtonAction?()
        } label: {
            Text("ABOUT")
                .font(.minionPro.bold.swiftUIFont(size: 16))
        }
    }
    
    private var videoButton: some View {
        Button {
            videoButtonAction?()
        } label: {
            Text("VIDEO")
                .font(.minionPro.bold.swiftUIFont(size: 16))
        }
    }
}

public extension View {
    func navigationBar(
        backButtonAction: (() -> Void)? = nil,
        aboutButtonAction: (() -> Void)?,
        videoButtonAction: (() -> Void)?) -> some View {
        modifier(NavigationBarModifier(
            backButtonAction: backButtonAction,
            aboutButtonAction: aboutButtonAction,
            videoButtonAction: videoButtonAction))
    }
}
