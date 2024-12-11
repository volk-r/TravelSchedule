//
//  UserAgreementViewModel.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 10.12.2024.
//

import Foundation

final class UserAgreementViewModel: ObservableObject {
    @Published var isLoadingError = false
    
    @Published var isLoading = true
    @Published var loadingProgress: Double = 0.0
}
