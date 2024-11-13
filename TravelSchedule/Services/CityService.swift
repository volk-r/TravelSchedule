//
//  CityService.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 05.11.2024.
//

import Foundation

import OpenAPIRuntime
import OpenAPIURLSession

final class CityService: CityServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getCity(lat: Double, lng: Double, distance: Int = AppConstants.defaultDistance) async throws -> City {
        let response = try await client.getCity(query: .init(
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }
}
