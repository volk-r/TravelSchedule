//
//  CitySelectionViewModel.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 01.12.2024.
//

import Foundation

@MainActor
final class CitySelectionViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var isLoading: Bool = false
    @Published var isError: NetworkErrorType? = nil
    
    @Published var citySelected: CityData = CityData(id: "", name: "", stations: [])
    @Published var isCitySelected: Bool = false
    
    @Published var searchText: String = ""
    
    private var networkService: NetworkServiceProtocol = NetworkService()
    
    var searchResult: [CityData] {
        guard !searchText.isEmpty else { return cities }
        return cities.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    private var cities: [CityData] = []
    private let allowedStationTypes: [String] = ["train_station", "airport", "bus_station", "river_port", "marine_station", "station"]
    
    // MARK: - selectCity
    
    func selectCity(_ city: CityData) {
        citySelected = city
        isCitySelected = true
    }
    
    // MARK: - fetchCities
    
    func fetchCities() async {
        await MainActor.run {
            isLoading = true
            isError = nil
        }
        
        var stationsFullList: StationsList
        
        do {
            // TODO: Sending 'self.networkService' risks causing data races; this is an error in the Swift 6 language mode
            stationsFullList = try await networkService.getStationsList()
        }
        catch {
            await MainActor.run {
                isLoading = false
                isError = .noInternetConnection
            }
            return
        }
        
        let stationsList = stationsFullList.countries?.first {
            $0.codes?.yandex_code == AppConstants.apiScheduleCountryRussiaId
        }
        
        guard let regionStationsList = stationsList?.regions else {
            await MainActor.run {
                isLoading = false
                isError = .serverError
            }
            return
        }
        
        var cityList: [CityData] = getCityList(regionStationsList: regionStationsList)
        
        await MainActor.run { [cityList] in
            cities = cityList
            isLoading = false
            isError = nil
        }
    }
    
    // MARK: - getCityList
    
    private func getCityList(regionStationsList: [Components.Schemas.Region]) -> [CityData] {
        var cityList: [CityData] = []
        
        regionStationsList.compactMap { $0.settlements }.forEach { settlements in
            settlements.forEach { settlement in
                guard
                    let id = settlement.codes?.yandex_code,
                    let title = settlement.title
                else {
                    return
                }
                
                var stations: [Station] = []
                settlement.stations?.forEach { station in
                    if
                        let stationId = station.codes?.yandex_code,
                        let stationName = station.title,
                        allowedStationTypes.contains(where: { element in
                            return element.lowercased() == station.station_type?.lowercased() ?? ""
                        }) {
                        stations.append(Station(id: stationId, name: stationName))
                    }
                }
                if !stations.isEmpty {
                    cityList.append(CityData(id: id, name: title, stations: stations))
                }
            }
        }
        
        return cityList
    }
}
