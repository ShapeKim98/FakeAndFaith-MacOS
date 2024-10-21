//
//  NavigationBarModifier.swift
//  DSKit
//
//  Created by 김도형 on 6/16/24.
//

import SwiftUI

import Util

struct NavigationBarModifier<T: View>: ViewModifier {
    @Environment(\.device)
    private var device
    
    private var backButtonAction: (() -> Void)?
    private var aboutButtonAction: (() -> Void)?
    private var videoButtonAction: (() -> Void)?
    
    @ViewBuilder
    private var noticeView: T
    
    init(
        backButtonAction: (() -> Void)? = nil,
        aboutButtonAction: (() -> Void)?,
        videoButtonAction: (() -> Void)?,
        noticeView: @escaping () -> T) {
            self.backButtonAction = backButtonAction
            self.aboutButtonAction = aboutButtonAction
            self.videoButtonAction = videoButtonAction
            self.noticeView = noticeView()
        }
    
    func body(content: Content) -> some View {
        Group {
            if device.isPhone {
                VStack(spacing: 0) {
                    bar
                    
                    content
                }
            } else {
                VStack(spacing: 0) {
                    bar
                    
                    content
                }
                .ignoresSafeArea()
            }
        }
        .background(.black)
    }
    
    var bar: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                
                title
                
                Spacer()
            }
            .overlay {
                HStack(spacing: 30) {
                    if (backButtonAction != nil) {
                        backButton
                    } else if device.isPhone {
                        aboutButton
                    }
                    
                    Spacer()
                    
                    if !device.isPhone {
                        aboutButton
                    }
                    
                    videoButton
                }
            }
            .padding(.horizontal, device.isPhone ? 20 : 100)
            .padding(.vertical, device.isPhone ? 16 : 28)
            .foregroundStyle(.white)
            .background(alignment: .bottom) {
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.main)
            }
            .background(.black)
            
            noticeView
        }
    }
    
    private var backButton: some View {
        Button {
            backButtonAction?()
        } label: {
            Text("뒤로가기")
                .font(.eulyoo1945.semiBold.swiftUIFont(size: device.isPhone ? 10 : 16))
        }
    }
    
    private var title: some View {
        Text("FAKE AND FAITH")
            .font(.minionPro.bold.swiftUIFont(size: device.isPhone ? 16 : 36))
            .foregroundStyle(.white)
    }
    
    private var aboutButton: some View {
        Button {
            aboutButtonAction?()
        } label: {
            Text("신앙심에 대하여")
                .font(.eulyoo1945.semiBold.swiftUIFont(size: device.isPhone ? 10 : 16))
        }
    }
    
    private var videoButton: some View {
        Button {
            videoButtonAction?()
        } label: {
            Text("메인영상")
                .font(.eulyoo1945.semiBold.swiftUIFont(size: device.isPhone ? 10 : 16))
        }
    }
}

public extension View {
    func navigationBar<T: View>(
        backButtonAction: (() -> Void)? = nil,
        aboutButtonAction: (() -> Void)?,
        videoButtonAction: (() -> Void)?,
        noticeView: @escaping () -> T = { EmptyView() }) -> some View {
            modifier(NavigationBarModifier(
                backButtonAction: backButtonAction,
                aboutButtonAction: aboutButtonAction,
                videoButtonAction: videoButtonAction,
                noticeView: noticeView))
        }
}
