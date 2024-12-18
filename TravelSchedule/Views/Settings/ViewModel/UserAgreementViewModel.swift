//
//  UserAgreementViewModel.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 10.12.2024.
//

import Foundation

@MainActor
final class UserAgreementViewModel: ObservableObject {
    @Published var isLoadingError = false
    
    @Published var isLoading = true
    @Published var loadingProgress: Double = 0.0
    
    init() {
        isLoading = true
        loadingProgress = 0.0
        isLoadingError = false
    }
}
