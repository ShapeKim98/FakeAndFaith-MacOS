//
//  NewsFeedView.swift
//  FeatureNewsFeed
//
//  Created by 김도형 on 9/29/24.
//

import SwiftUI
import WebKit

import ComposableArchitecture

public struct NewsFeedView: UIViewRepresentable {
    @StateObject
    private var coordinator: Coordinator
    
    public init(store: StoreOf<NewFeedFeature>) {
        self._coordinator = StateObject(wrappedValue: Coordinator(store: store))
    }
    
    public func makeCoordinator() -> Coordinator {
        self.coordinator
    }
    
    public func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        
        let request = URLRequest(url: URL(string: "https://thegod.imweb.me")!)
        webView.load(request)
        
        return webView
    }
    
    
    public func updateUIView(_ uiView: UIViewType, context: Context) { }
}

extension NewsFeedView {
    public class Coordinator: NSObject, ObservableObject, WKNavigationDelegate {
        private let store: StoreOf<NewFeedFeature>
        
        public init(store: StoreOf<NewFeedFeature>) {
            self.store = store
        }
        
        public func webView(
            _ webView: WKWebView,
            didStartProvisionalNavigation navigation: WKNavigation!
        ) {
            store.send(.updateNavigationState(
                canGoBack: webView.canGoBack,
                canGoForward: webView.canGoForward
            ))
        }
        
        public func webView(
            _ webView: WKWebView,
            didFinish navigation: WKNavigation!
        ) {
            store.send(.updateNavigationState(
                canGoBack: webView.canGoBack,
                canGoForward: webView.canGoForward
            ))
        }
        
        public func webView(
            _ webView: WKWebView,
            didCommit navigation: WKNavigation!
        ) {
            store.send(.updateNavigationState(
                canGoBack: webView.canGoBack,
                canGoForward: webView.canGoForward
            ))
        }
    }
}

#Preview {
    NewsFeedView(store: .init(initialState: .init(), reducer: {
        NewFeedFeature()
    }))
}
