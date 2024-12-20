//
//  CityData.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 18.12.2024.
//

import Foundation

struct CityData: Identifiable, Hashable, Sendable {
    let id: String
    let name: String
    let stations: [Station]
}
