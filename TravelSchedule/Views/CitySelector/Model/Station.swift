//
//  Station.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 18.12.2024.
//

import Foundation

struct Station: Identifiable, Hashable, Sendable {
    let id: String
    let name: String
    let description: StationDescription?
}
