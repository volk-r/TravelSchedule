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
    let city: String?
    let station: Station?
    var description: String {
        guard
            let city = city,
            let station = station
        else {
            return stationType.prompt
        }
        return city + " (" + station.name + ")"
    }
    
    init(stationType: StationType) {
        self.stationType = stationType
        self.city = nil
        self.station = nil
    }
    
    init(stationType: StationType, city: String?, station: Station?) {
        self.stationType = stationType
        self.city = city
        self.station = station
    }
}
