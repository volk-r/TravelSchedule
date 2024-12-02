//
//  StationType.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 02.12.2024.
//

import Foundation

enum StationType {
    case from
    case to
    
    var prompt: String {
        switch self {
        case .from: return String(localized: "From")
        case .to: return String(localized: "To")
        }
    }
}
