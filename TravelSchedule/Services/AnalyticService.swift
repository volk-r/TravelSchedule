//
//  AnalyticService.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 22.12.2024.
//

import Foundation
import AppMetricaCore

typealias AnalyticsEventParams = [AnyHashable: Any]

struct AnalyticService: AnalyticServiceProtocol {
    static func activate() {
        guard
            let configuration = AppMetricaConfiguration(apiKey: AppConstants.appMetricaKey)
        else { return }
        
        AppMetrica.activate(with: configuration)
    }
}

extension AnalyticService {
    static func trackOpenScreen(screen: AnalyticScreen) {
        reportEvent(event: Events.open.rawValue, screen: screen.rawValue)
    }
    
    static func trackCloseScreen(screen: AnalyticScreen) {
        reportEvent(event: Events.close.rawValue, screen: screen.rawValue)
    }
    
    static func trackClick(screen: AnalyticScreen, item: AnalyticItems, extraData: AnalyticsEventParams? = nil) {
        let params: AnalyticsEventParams
        if let extraData {
            params = ["item": item.rawValue].merging(extraData, uniquingKeysWith: { $1 })
        } else {
            params = ["item": item.rawValue]
        }
        
        reportEvent(event: Events.click.rawValue, screen: screen.rawValue, item: params)
    }
}

private extension AnalyticService {
    static private func reportEvent(event: String, screen: String, item: AnalyticsEventParams? = nil) {
        let params: AnalyticsEventParams
        if let item {
            params = ["event": event, "screen": screen].merging(item, uniquingKeysWith: { $1 })
        } else {
            params = ["event": event, "screen": screen]
        }
        
        AppMetrica.reportEvent(name: "EVENT", parameters: params, onFailure: { (error) in
            print("REPORT ERROR: %@", error.localizedDescription)
        })
    }
    
    private enum Events: String, CaseIterable {
        case open = "open"
        case close = "close"
        case click = "click"
    }
}
