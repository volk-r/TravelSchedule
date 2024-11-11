//
//  StationsListService.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 07.11.2024.
//

import Foundation

typealias NotFoundResponse = Components.Schemas.NotFoundResponse

struct NotFoundError: Error {
    let response: NotFoundResponse
}

struct ResponseOtherError: Error {
    let response: String
}

final class StationsListService: StationsListServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getStationsList() async throws -> StationsList {
        let response = try await client.getStationsList()
        let httpBody = try response.ok.body.html
        let stationList = try await JSONDecoder().decode(from: httpBody, to: StationsList.self)
        return stationList
    }
}
