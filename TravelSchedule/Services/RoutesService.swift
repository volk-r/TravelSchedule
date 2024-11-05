//
//  RoutesService.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 05.11.2024.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

final class RoutesService: RoutesServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getRoutes(uid: String, from origin: String?, to destination: String?, date: String?) async throws -> Routes {
        let response = try await client.getRoutes(query: .init(
            apikey: apikey,
            uid: uid,
            from: origin,
            to: destination,
            date: date
        ))
        return try response.ok.body.json
    }
}
