//
//  TimeOfDay.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 29.11.2024.
//

import Foundation

enum TimeOfDay: String, FilterOptionProtocol {
    static let title: LocalizedStringResource = "Departure time"
    
    var id : String { UUID().uuidString }
    
    case morning
    case afternoon
    case evening
    case night
}

extension TimeOfDay {
    var description: LocalizedStringResource {
        switch self {
        case .morning: return "Morning 06:00 - 12:00"
        case .afternoon: return "Afternoon 12:00 - 18:00"
        case .evening: return "Evening 18:00 - 00:00"
        case .night: return "Night 00:00 - 06:00"
        }
    }
}
