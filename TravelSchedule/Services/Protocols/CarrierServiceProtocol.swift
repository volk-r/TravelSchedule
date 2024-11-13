//
//  CarrierServiceProtocol.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 05.11.2024.
//

import Foundation

typealias Carrier = Components.Schemas.CarrierResponse

protocol CarrierServiceProtocol {
    func getCarriers(code: Int) async throws -> Carrier
}
