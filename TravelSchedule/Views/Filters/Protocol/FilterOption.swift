//
//  FilterOption.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 29.11.2024.
//

import Foundation

protocol FilterOptionProtocol: CaseIterable, Identifiable, Hashable {
    static var title: LocalizedStringResource { get }
    var description: LocalizedStringResource { get }
}
