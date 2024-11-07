//
//  SearchRoutesService.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 07.11.2024.
//

import Foundation

import OpenAPIRuntime
import OpenAPIURLSession

final class SearchRoutesService: SearchRoutesServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func searchRoutes(from origin: String, to destination: String) async throws -> SearchResponse {
        let response = try await client.getRouteList(query: .init(from: origin, to: destination))
        return try response.ok.body.json
    }
}
