//
//  RoutesServiceProtocol.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 05.11.2024.
//

import Foundation

typealias Route = Components.Schemas.Route

protocol RouteServiceProtocol {
    func getRoute(uid: String, from origin: String?, to destination: String?, date: String?) async throws -> Route
}
