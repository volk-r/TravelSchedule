//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 31.10.2024.
//

import SwiftUI
import OpenAPIURLSession

@main
struct TravelScheduleApp: App {
    
    @StateObject private var appSettings = AppSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modifier(.colorScheme)
                .environmentObject(appSettings)
        }
    }
}

extension TravelScheduleApp {
    private func getClient() throws -> Client {
        Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: AppConstants.apiScheduleKey)]
        )
    }
    
    func searchRoutes(from origin: String, to destination: String) async throws -> SearchResponse {
        let service = SearchRoutesService(client: try getClient())
        return try await service.searchRoutes(from: origin, to: destination)
    }
    
    func getNearestStations(lat: Double, lng: Double, distance: Int = AppConstants.defaultDistance) async throws -> NearestStations {
        let service = NearestStationsService(client: try getClient())
        return try await service.getNearestStations(lat: lat, lng: lng, distance: distance)
    }
    
    func getSchedule(station: String) async throws -> ScheduleResponse {
        let service = ScheduleService(client: try getClient())
        return try await service.getSchedule(station: "s9613062")
    }
    
    func getCopyright() async throws -> Copyright {
        let service = CopyrightService(client: try getClient())
        return try await service.getCopyright()
    }
    
    func getRoute(
        uid: String,
        stationCode: StationCode? = nil,
        from origin: String? = nil,
        to destination: String? = nil,
        date: String? = nil
    ) async throws -> Route {
        let service = RouteService(client: try getClient())
        return try await service
            .getRoute(
                uid: uid,
                stationCode: stationCode,
                from: origin,
                to: destination,
                date: date
            )
    }
    
    func getCity(lat: Double, lng: Double, distance: Int = AppConstants.defaultDistance) async throws -> City {
        let service = CityService(client: try getClient())
        return try await service.getCity(lat: lat, lng: lng, distance: distance)
    }
    
    func getCarriers(code carriersCode: Int) async throws -> Carrier {
        let service = CarrierService(client: try getClient())
        return try await service.getCarriers(code: carriersCode)
    }
    
    func getStationsList() async throws -> StationsList {
        let service = StationsListService(client: try getClient())
        return try await service.getStationsList()
    }
}
