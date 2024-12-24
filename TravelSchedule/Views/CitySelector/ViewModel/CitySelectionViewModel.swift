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
    
    var searchResult: [CityData] {
        guard !searchText.isEmpty else { return cities }
        return cities.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    private let networkService: some NetworkServiceProtocol = NetworkService()
    
    private var cities: [CityData] = []
    
    // MARK: - init
    
    init() {
        AnalyticService.trackOpenScreen(screen: .citySelection)
    }
    
    // MARK: - selectCity
    
    func selectCity(_ city: CityData) {
        let extraData: AnalyticsEventParams = ["cityId": city.id, "cityName": city.name]
        AnalyticService.trackClick(screen: .citySelection, item: .selectCity, extraData: extraData)
        
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
        
        let cityList: [CityData] = getCityList(regionStationsList: regionStationsList)
        
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
                        StationDescription.allCases.contains(where: { element in
                            return element.rawValue.lowercased() == station.station_type?.lowercased() ?? ""
                        })
                    {
                        var description: StationDescription? = nil
                        if let stationType = station.station_type {
                            description = StationDescription.init(rawValue: stationType)
                        }
                        stations.append(Station(id: stationId, name: stationName, description: description))
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
