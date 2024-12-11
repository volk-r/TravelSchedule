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
        NavigationStack {
            TabView(selection: $selectedTab) {
                SelectStationView()
                    .tabItem {
                        Image(AppImages.mainPageTabbar)
                            .renderingMode(.template)
                    }
                    .tag(TabTags.mainPage)
                
                SettingsView()
                    .tabItem {
                        Image(AppImages.settingsPageTabbar)
                            .renderingMode(.template)
                    }
                    .tag(TabTags.settingsPage)
            }
            .tint(AppColorSettings.fontColor)
        }
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
        .modifier(.colorScheme)
        .environmentObject(AppSettings())
}
