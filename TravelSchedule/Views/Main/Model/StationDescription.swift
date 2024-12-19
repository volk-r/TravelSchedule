//
//  StationDescription.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 19.12.2024.
//

import Foundation

enum StationDescription: String, Equatable, CaseIterable {
    case train = "train_station"
    case airport = "airport"
    case busStation = "bus_station"
    case riverPort = "river_port"
    case seaPort = "marine_station"
    case station = "station"
    
    var description: String {
        switch self {
        case .train: return String(localized: "train station")
        case .airport: return String(localized: "airport")
        case .busStation: return String(localized: "bus station")
        case .riverPort: return String(localized: "river port")
        case .seaPort: return String(localized: "sea port")
        case .station: return String(localized: "station")
        }
    }
}
