//
//  RouteSelectionViewModel.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 30.11.2024.
//

import Foundation

final class RouteSelectionViewModel: ObservableObject {
    @Published var cardData: RouteCardData?
    @Published var isCarrierPagePresented: Bool = false

    func setup(data: RouteCardData) {
        self.cardData = data
    }
}
