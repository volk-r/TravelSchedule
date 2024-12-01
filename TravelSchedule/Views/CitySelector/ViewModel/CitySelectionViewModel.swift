//
//  CitySelectionViewModel.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 01.12.2024.
//

import Foundation

final class CitySelectionViewModel: ObservableObject {
    @Published var citySelected: String = ""
    @Published var isCitySelected: Bool = false
    
    func selectCity(_ city: String) {
        citySelected = city
        isCitySelected = true
    }
}
