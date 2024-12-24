//
//  UserAgreementViewModel.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 10.12.2024.
//

import Foundation

@MainActor
final class UserAgreementViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var isLoadingError = false
    
    @Published var isLoading = true
    @Published var loadingProgress: Double = 0.0
    
    // MARK: - init
    
    init() {
        AnalyticService.trackOpenScreen(screen: .userAgreement)
        isLoading = true
        loadingProgress = 0.0
        isLoadingError = false
    }
}
