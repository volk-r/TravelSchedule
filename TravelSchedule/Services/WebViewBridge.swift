//
//  WebViewBridge.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 27.11.2024.
//

import SwiftUI
import WebKit

struct WebViewBridge: UIViewRepresentable {
    
    // MARK: - Properties
    
    @EnvironmentObject var model: UserAgreementViewModel
    
    let url: String
    
    private let webView = WKWebView()
    
    // MARK: - Methods
    
    func makeUIView(context: Context) -> WKWebView {
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

// MARK: - Coordinator

extension WebViewBridge {
    class Coordinator: NSObject, WKNavigationDelegate {
        private var parent: WebViewBridge
        private var estimatedProgressObservation: NSKeyValueObservation?
        
        init(_ parent: WebViewBridge) {
            self.parent = parent
            super.init()
            self.parent.webView.navigationDelegate = self
            
            estimatedProgressObservation = self.parent.webView.observe(
                \.estimatedProgress,
                 options: [],
                 changeHandler: { [weak self] webView, _ in
                     guard let self = self else { return }
                     Task { @MainActor in
                         self.parent.model.loadingProgress = webView.estimatedProgress
                     }
                 })
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            self.parent.model.isLoading = true
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.parent.model.isLoading = false
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            self.parent.model.isLoading = false
            self.parent.model.loadingProgress = 0.0
            self.parent.model.isLoadingError = true
        }
    }
}
