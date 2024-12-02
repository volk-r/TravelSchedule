//
//  SettingsViewModel.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 02.12.2024.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    @Published var isDarkModeEnabled = false
    @Published var isUserAgreementPresented: Bool = false
    
    @Published var appVersion: String = ""
    
    private var appSettings: AppSettings?
    
    func setDarkMode(isEnabled: Bool) {
        appSettings?.isDarkModeEnabled = isEnabled
    }
    
    func loadAppSetting(_ appSettings: AppSettings) {
        self.appSettings = appSettings
        appVersion = String(localized: "Version") + " " + appSettings.getAppVersion()
        isDarkModeEnabled = appSettings.isDarkModeEnabled
    }
}
