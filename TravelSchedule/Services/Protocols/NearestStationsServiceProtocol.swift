//
//  NearestStationsServiceProtocol.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 04.11.2024.
//

import Foundation

typealias NearestStations = Components.Schemas.Stations

protocol NearestStationsServiceProtocol {
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
}
