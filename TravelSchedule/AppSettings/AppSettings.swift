//
//  AppSettings.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 02.12.2024.
//

import SwiftUI

final class AppSettings: ObservableObject {
    @AppStorage("darkMode") var isDarkModeEnabled: Bool = false
    
    func getAppVersion() -> String {
        guard
            let nsObject = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? AnyObject,
            let appVersion = nsObject as? String
        else {
            return ""
        }
        return appVersion
    }
}
