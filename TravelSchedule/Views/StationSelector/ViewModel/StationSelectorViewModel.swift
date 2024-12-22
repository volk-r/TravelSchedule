//
//  StationSelectorViewModel.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 01.12.2024.
//

import Foundation

@MainActor
final class StationSelectorViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var isLoading: Bool = true
    @Published var isError: NetworkErrorType? = nil
    
    @Published var searchText: String = ""
    
    var searchResult: [Station] {
        guard !searchText.isEmpty else { return stations }
        return stations.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    private var stations: [Station] = []
    
    // MARK: - init
    
    init() {
        AnalyticService.trackOpenScreen(screen: .stationSelection)
    }
    
    // MARK: - selectStation
    
    func selectStation(
        station: Station,
        from city: CityData,
        withStationData stationData: inout StationData
    ) {
        let extraData: AnalyticsEventParams = ["stationId": station.id, "stationName": station.name]
        AnalyticService.trackClick(screen: .stationSelection, item: .selectStation, extraData: extraData)
        
        stationData = StationData.init(
            stationType: stationData.stationType,
            city: city.name,
            station: station
        )
    }
    
    // MARK: - setStations
    
    func setStations(stationsList: [Station]) {
        self.stations = stationsList
        self.isLoading = false
    }
}
