//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 31.10.2024.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    
    @State private var selectedTab: TabTags = .mainPage
    
    var body: some View {
        TabView(selection: $selectedTab) {
            SelectStationView()
                .tabItem {
                    Image(systemName: AppImages.mainPageTabbarImage)
                }
                .tag(TabTags.mainPage)
            
            SettingsView()
                .tabItem {
                    Image(systemName: AppImages.settingsPageTabbarImage)
                }
                .tag(TabTags.settingsPage)
        }
        .accentColor(AppColorSettings.fontColor)
    }
}

extension ContentView {
    
    // MARK: - TabTags
    
    private enum TabTags: Int, CaseIterable {
        case mainPage
        case settingsPage
    }
}

#Preview {
    ContentView()
}
