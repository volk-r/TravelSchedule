//
//  RoutesServiceProtocol.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 05.11.2024.
//

import Foundation

typealias Route = Components.Schemas.Route
typealias StationCode = Operations.getRoute.Input.Query.show_systemsPayload

protocol RouteServiceProtocol {
    func getRoute(
        uid: String,
        stationCode: StationCode?,
        from origin: String?,
        to destination: String?,
        date: String?
    ) async throws -> Route
}
