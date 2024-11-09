//
//  CityServiceProtocol.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 05.11.2024.
//

import Foundation

typealias City = Components.Schemas.City

protocol CityServiceProtocol {
    func getCity(lat: Double, lng: Double, distance: Int?) async throws -> City
}
