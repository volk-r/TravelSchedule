//
//  CopyrightServiceProtocol.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 08.11.2024.
//

import Foundation

typealias Copyright = Components.Schemas.Copyright

protocol CopyrightServiceProtocol {
    func getCopyright() async throws -> Copyright
}
