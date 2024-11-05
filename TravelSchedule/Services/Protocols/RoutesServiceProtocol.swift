//
//  RoutesServiceProtocol.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 05.11.2024.
//

import Foundation

typealias Routes = Components.Schemas.ThreadResponse

protocol RoutesServiceProtocol {
    func getRoutes(uid: String, from origin: String?, to destination: String?, date: String?) async throws -> Routes
}
