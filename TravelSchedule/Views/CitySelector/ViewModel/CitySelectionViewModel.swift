//
//  CitySelectionViewModel.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 01.12.2024.
//

import Foundation

final class CitySelectionViewModel: ObservableObject {
    @Published var isLoadingError: Bool = false
    
    @Published var citySelected: String = ""
    @Published var isCitySelected: Bool = false
    
    @Published var searchText: String = ""
    
    var searchResult: [String] {
        guard !searchText.isEmpty else { return cities }
        return cities.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }
    
    private let cities = ["Москва", "Санкт-Петербург", "Сочи", "Горный воздух", "Краснодар", "Казань", "Омск"]
    
    func selectCity(_ city: String) {
        citySelected = city
        isCitySelected = true
    }
}
