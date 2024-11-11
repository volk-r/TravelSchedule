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
    
    init(client: Client) {
        self.client = client
    }
    
    func searchRoutes(from origin: String, to destination: String) async throws -> SearchResponse {
        let response = try await client.getRouteList(
            query: .init(
                from: origin,
                to: destination
            )
        )
        print(response)
        return try response.ok.body.json
    }
}
