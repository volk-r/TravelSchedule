//
//  AnalyticServiceProtocol.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 22.12.2024.
//

import Foundation

protocol AnalyticServiceProtocol {
    static func activate()
    static func trackOpenScreen(screen: AnalyticScreen)
    static func trackCloseScreen(screen: AnalyticScreen)
    static func trackClick(screen: AnalyticScreen, item: AnalyticItems, extraData: AnalyticsEventParams?)
}
