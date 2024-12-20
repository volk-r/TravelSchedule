//
//  ScheduleService.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 06.11.2024.
//

import Foundation

import OpenAPIRuntime
import OpenAPIURLSession

actor ScheduleService: ScheduleServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getSchedule(station: String) async throws -> ScheduleResponse {
        let response = try await client.getSchedule(query: .init(station: station))
        return try response.ok.body.json
    }
}
