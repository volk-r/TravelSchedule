//
//  CopyrightService.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 08.11.2024.
//

import Foundation

actor CopyrightService: CopyrightServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getCopyright() async throws -> Copyright {
        let response = try await client.getCopyright()
        return try response.ok.body.json
    }
}
