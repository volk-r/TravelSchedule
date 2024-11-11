//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 31.10.2024.
//

import SwiftUI
import OpenAPIURLSession

@main
struct TravelScheduleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

extension TravelScheduleApp {
    private func getClient() throws -> Client {
        Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: AppConstants.apiScheduleKey)]
        )
    }
    
    func searchRoutes(from origin: String, to destination: String) async throws -> SearchResponse {
        let service = SearchRoutesService(client: try getClient())
        return try await service.searchRoutes(from: origin, to: destination)
    }
}
