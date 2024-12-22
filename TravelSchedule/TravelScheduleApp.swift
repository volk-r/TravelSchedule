//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 31.10.2024.
//

import SwiftUI

@main
struct TravelScheduleApp: App {
    
    @StateObject private var appSettings = AppSettings()
    
    init() {
        AnalyticService.activate()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modifier(.colorScheme)
                .environmentObject(appSettings)
        }
    }
}
