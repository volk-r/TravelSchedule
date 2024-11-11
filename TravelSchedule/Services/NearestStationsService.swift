//
//  NearestStationsService.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 04.11.2024.
//

import Foundation

import OpenAPIRuntime
import OpenAPIURLSession

final class NearestStationsService: NearestStationsServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getNearestStations(lat: Double, lng: Double, distance: Int = AppConstants.defaultDistance) async throws -> NearestStations {
        let response = try await client.getNearestStations(query: .init(
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }
}
