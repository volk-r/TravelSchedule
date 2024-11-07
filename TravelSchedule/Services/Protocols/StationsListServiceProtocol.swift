//
//  StationsListServiceProtocol.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 07.11.2024.
//

import Foundation

typealias StationsList = Components.Schemas.StationsList

protocol StationsListServiceProtocol {
    func getStationsList() async throws -> StationsList
}
