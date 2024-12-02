//
//  StationSelectorViewModel.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 01.12.2024.
//

import Foundation

final class StationSelectorViewModel: ObservableObject {
    @Published var isLoadingError: Bool = false
    @Published var searchText: String = ""
    
    var searchResult: [String] {
        guard !searchText.isEmpty else { return stations }
        return stations.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }
    
    private let stations = ["Киевский вокзал", "Курский вокзал", "Ярославский вокзал", "Белорусский вокзал", "Савеловский вокзал", "Ленинградский вокзал"]
    
    func selectStation(station: String, withStationData stationData: inout String) {
        stationData = station
    }
}
