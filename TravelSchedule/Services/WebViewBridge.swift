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
    
    let url: String
    
    private let webView = WKWebView()
    
    @Binding var isLoading: Bool
    @Binding var isLoadingError: Bool
    @Binding var progress: Double
    
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
                     self.parent.progress = webView.estimatedProgress
                 })
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            self.parent.isLoading = true
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.parent.isLoading = false
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            self.parent.isLoading = false
            self.parent.progress = 0.0
            self.parent.isLoadingError = true
        }
    }
}
