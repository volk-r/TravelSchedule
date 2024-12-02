//
//  DarkModeViewModifier.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 02.12.2024.
//

import SwiftUI

struct DarkModeViewModifier: ViewModifier {
    @ObservedObject var appSettings: AppSettings = AppSettings()
    
    public func body(content: Content) -> some View {
        content
            .environment(\.colorScheme, appSettings.isDarkModeEnabled ? .dark : .light)
            .preferredColorScheme(appSettings.isDarkModeEnabled ? .dark : .light)
    }
}
