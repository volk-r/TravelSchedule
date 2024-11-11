//
//  CarrierService.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 05.11.2024.
//

import Foundation

import OpenAPIRuntime
import OpenAPIURLSession

final class CarrierService: CarrierServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getCarriers(code: Int) async throws -> Carrier {
        let response = try await client.getCarriers(query: .init(code: code))
        return try response.ok.body.json
    }
}
