//
//  RouteService.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 05.11.2024.
//

import Foundation

import OpenAPIRuntime
import OpenAPIURLSession

final class RouteService: RouteServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getRoute(
        uid: String,
        stationCode: StationCode? = nil,
        from origin: String? = nil,
        to destination: String? = nil,
        date: String? = nil
    ) async throws -> Route {
        let response = try await client.getRoute(query: .init(
            apikey: apikey,
            uid: uid,
            from: origin,
            to: destination,
            date: date,
            show_systems: stationCode
        ))
        return try response.ok.body.json
    }
}
