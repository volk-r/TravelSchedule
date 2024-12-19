//
//  SearchRoutesServiceProtocol.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 07.11.2024.
//

import Foundation

typealias SearchResponse = Components.Schemas.SearchResponse

protocol SearchRoutesServiceProtocol {
    func searchRoutes(from origin: String, to destination: String, date: String?, hasTransfers: Bool?) async throws -> SearchResponse
}
