//
//  NetworkServiceProtocol.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 18.12.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func searchRoutes(
        from origin: String,
        to destination: String,
        date: String?,
        hasTransfers: Bool?
    ) async throws -> SearchResponse
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
    func getSchedule(station: String) async throws -> ScheduleResponse
    func getCopyright() async throws -> Copyright
    func getRoute(
        uid: String,
        stationCode: StationCode?,
        from origin: String?,
        to destination: String?,
        date: String?
    ) async throws -> Route
    func getCity(lat: Double, lng: Double, distance: Int) async throws -> City
    func getCarriers(code carriersCode: Int) async throws -> Carrier
    func getStationsList() async throws -> StationsList
}
