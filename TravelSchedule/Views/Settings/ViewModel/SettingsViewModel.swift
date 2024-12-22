//
//  SettingsViewModel.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 02.12.2024.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var isDarkModeEnabled = false
    @Published var isUserAgreementPresented: Bool = false
    
    @Published var appVersion: String = ""
    
    private var appSettings: AppSettings?
    
    // MARK: - init
    
    init () {
        AnalyticService.trackOpenScreen(screen: .settings)
    }
    
    // MARK: - setDarkMode
    
    func setDarkMode(isEnabled: Bool) {
        let darkModeAnalyticItem: AnalyticItems = isEnabled ? .darkModeEnabled : .darkModeDisabled
        AnalyticService.trackClick(screen: .settings, item: darkModeAnalyticItem)
        
        appSettings?.isDarkModeEnabled = isEnabled
    }
    
    // MARK: - loadAppSetting
    
    func loadAppSetting(_ appSettings: AppSettings) {
        self.appSettings = appSettings
        appVersion = String(localized: "Version") + " " + appSettings.getAppVersion()
        isDarkModeEnabled = appSettings.isDarkModeEnabled
    }
}
