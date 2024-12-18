//
//  UserAgreementView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 27.11.2024.
//

import SwiftUI

struct UserAgreementView: View {
    
    // MARK: - Properties
    
    @Binding var isShowRoot: Bool
    
    @StateObject private var model: UserAgreementViewModel = UserAgreementViewModel()

    var body: some View {
        ZStack {
            AppColorSettings.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ProgressView(value: model.loadingProgress)
                    .progressViewStyle(.linear)
                    .opacity(model.loadingProgress == 1.0 ? 0 : 1)
                ZStack {
                    if model.isLoadingError {
                        NetworkErrorView(errorType: .noInternetConnection)
                    } else {
                        WebViewBridge(
                            url: AppConstants.userAgreementURL,
                            isLoading: $model.isLoading,
                            isLoadingError: $model.isLoadingError,
                            progress: $model.loadingProgress
                        )
                        
                        if model.isLoading {
                            ProgressView()
                        }
                    }
                }
            }
            .navigationTitle("User agreement")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .backButtonToolbarItem(isShowRoot: $isShowRoot)
            .ignoresSafeArea(edges: [.leading, .trailing, .bottom])
        }
    }
}

#Preview {
    NavigationStack {    
        UserAgreementView(isShowRoot: .constant(false))
    }
}
