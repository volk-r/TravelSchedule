//
//  ScheduleServiceProtocol.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 06.11.2024.
//

import Foundation

typealias ScheduleResponse = Components.Schemas.ScheduleResponse

protocol ScheduleServiceProtocol {
    func getSchedule(station: String) async throws -> ScheduleResponse
}
