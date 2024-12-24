//
//  FilterTime.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 21.12.2024.
//

import Foundation

struct FilterTime: Hashable, Identifiable, Sendable {
    let id = UUID()
    let time: TimeOfDay
    var isSelected: Bool
}
