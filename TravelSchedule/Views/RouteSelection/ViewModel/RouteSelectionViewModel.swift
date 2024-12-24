//
//  RouteSelectionViewModel.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 30.11.2024.
//

import Foundation

@MainActor
final class RouteSelectionViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var cardData: RouteCardData?
    
    // MARK: - setup

    func setup(data: RouteCardData) {
        self.cardData = data
    }
}
