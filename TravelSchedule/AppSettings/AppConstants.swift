//
//  AppConstants.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 04.11.2024.
//

import SwiftUI

enum AppConstants {
    static let apiScheduleKey = "481665d9-4609-4b54-ac58-e304d876c93b"
    static let apiScheduleCountryRussiaId = "l225"
    
    static let userAgreementURL: String = "https://yandex.ru/legal/practicum_offer/"
    
    static let defaultDistance: Int = 50
    
    static let defaultCornerRadius: CGFloat = 16
    
    static let fontRegular12: Font = .system(size: 12, weight: .regular, design: .default)
    static let fontRegular17: Font = .system(size: 17, weight: .regular, design: .default)
    static let fontRegular20: Font = .system(size: 20, weight: .regular, design: .default)
    
    static let fontBold17: Font = .system(size: 17, weight: .bold, design: .default)
    static let fontBold24: Font = .system(size: 24, weight: .bold, design: .default)
    static let fontBold34: Font = .system(size: 34, weight: .bold, design: .default)
    
    static let animationVelocity: TimeInterval = 0.4
}
