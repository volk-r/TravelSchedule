//
//  StationsListService.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 07.11.2024.
//

import Foundation

final class StationsListService: StationsListServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getStationsList() async throws -> StationsList {
        let response = try await client.getStationsList(query: .init(apikey: apikey))
        return try response.ok.body.json
    }
}
