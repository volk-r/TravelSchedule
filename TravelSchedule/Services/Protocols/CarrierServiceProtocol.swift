//
//  CarrierServiceProtocol.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 05.11.2024.
//

import Foundation

typealias Carriers = Components.Schemas.Carriers

protocol CarrierServiceProtocol {
    func getCarriers(code: String) async throws -> Carriers
}
