//
//  UserAgreementView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 27.11.2024.
//

import SwiftUI

struct UserAgreementView: View {
    
    // MARK: - Properties

    @State private var isLoading = true
    @State private var loadingProgress: Double = 0.0
    @State private var isLoadingError = false

    var body: some View {
        ZStack {
            AppColorSettings.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ProgressView(value: loadingProgress)
                    .progressViewStyle(.linear)
                    .opacity(loadingProgress == 1.0 ? 0 : 1)
                ZStack {
                    WebViewBridge(
                        url: AppConstants.userAgreementURL,
                        isLoading: $isLoading,
                        isLoadingError: $isLoadingError,
                        progress: $loadingProgress
                    )
                    .opacity(isLoadingError ? 0 : 1)
                    ProgressView()
                        .opacity(isLoading ? 1 : 0)
                    NetworkErrorView(errorType: .noInternetConnection)
                        .opacity(isLoadingError ? 1 : 0)
                }
            }
            .navigationTitle("User agreement")
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea(edges: [.leading, .trailing, .bottom])
            .onAppear {
                isLoading = true
                loadingProgress = 0.0
                isLoadingError = false
            }
        }
    }
}

#Preview {
    UserAgreementView()
}
