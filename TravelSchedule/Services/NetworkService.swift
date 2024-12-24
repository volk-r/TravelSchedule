//
//  NetworkClient.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 18.12.2024.
//

import Foundation
import OpenAPIURLSession

actor NetworkService: NetworkServiceProtocol {
    
    // MARK: - getClient
    
    private static func getClient() throws -> Client {
        Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: AppConstants.apiScheduleKey)]
        )
    }
    
    // MARK: - searchRoutes
    
    func searchRoutes(
        from origin: String,
        to destination: String,
        date: String?,
        hasTransfers: Bool?
    ) async throws -> SearchResponse {
        let service = SearchRoutesService(client: try NetworkService.getClient())
        return try await service.searchRoutes(from: origin, to: destination, date: date, hasTransfers: hasTransfers)
    }
    
    // MARK: - getNearestStations
    
    func getNearestStations(lat: Double, lng: Double, distance: Int = AppConstants.defaultDistance) async throws -> NearestStations {
        let service = NearestStationsService(client: try NetworkService.getClient())
        return try await service.getNearestStations(lat: lat, lng: lng, distance: distance)
    }
    
    // MARK: - getSchedule
    
    func getSchedule(station: String) async throws -> ScheduleResponse {
        let service = ScheduleService(client: try NetworkService.getClient())
        return try await service.getSchedule(station: station)
    }
    
    // MARK: - getCopyright
    
    func getCopyright() async throws -> Copyright {
        let service = CopyrightService(client: try NetworkService.getClient())
        return try await service.getCopyright()
    }
    
    // MARK: - getRoute
    
    func getRoute(
        uid: String,
        stationCode: StationCode? = nil,
        from origin: String? = nil,
        to destination: String? = nil,
        date: String? = nil
    ) async throws -> Route {
        let service = RouteService(client: try NetworkService.getClient())
        return try await service
            .getRoute(
                uid: uid,
                stationCode: stationCode,
                from: origin,
                to: destination,
                date: date
            )
    }
    
    // MARK: - getCity
    
    func getCity(lat: Double, lng: Double, distance: Int = AppConstants.defaultDistance) async throws -> City {
        let service = CityService(client: try NetworkService.getClient())
        return try await service.getCity(lat: lat, lng: lng, distance: distance)
    }
    
    // MARK: - getCarriers
    
    func getCarriers(code carriersCode: Int) async throws -> Carrier {
        let service = CarrierService(client: try NetworkService.getClient())
        return try await service.getCarriers(code: carriersCode)
    }
    
    // MARK: - getStationsList
    
    func getStationsList() async throws -> StationsList {
        let service = StationsListService(client: try NetworkService.getClient())
        return try await service.getStationsList()
    }
}
