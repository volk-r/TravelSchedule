//
//  StationData.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 02.12.2024.
//

import Foundation

struct StationData: Identifiable, Hashable, Sendable {
    let id = UUID()
    let stationType: StationType
    var city: String?
    var station: String?
    var description: String {
        guard
            let city = city,
            let station = station
        else {
            return stationType.prompt
        }
        return city + " (" + station + ")"
    }
    
    init(stationType: StationType) {
        self.stationType = stationType
    }
}
