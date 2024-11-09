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
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getCarriers(code: Int) async throws -> Carrier {
        let response = try await client.getCarriers(query: .init(apikey: apikey, code: code))
        return try response.ok.body.json
    }
}
