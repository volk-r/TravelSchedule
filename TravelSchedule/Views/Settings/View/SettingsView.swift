//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 26.11.2024.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Properties
    
    @State private var isDarkModeEnabled = true
    
    var body: some View {
        ZStack {
            AppColorSettings.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                settingsList
                Spacer()
                copyright
            }
        }
    }
}

extension SettingsView {
    
    // MARK: - settingsList
    
    private var settingsList: some View {
        List {
            Section {
                Toggle(
                    "Dark mode",
                    isOn: $isDarkModeEnabled
                )
                .font(AppConstants.fontBold17)
                .tint(AppColorSettings.backgroundButtonColor)
                .padding(.bottom)
                
                Text("User Agreement")
                    .font(AppConstants.fontBold17)
                    .badge(
                        Text("\(Image(systemName: "chevron.right"))")
                    )
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .padding(.top)
    }
    
    // MARK: - copyright
    
    private var copyright: some View {
        VStack {
            Text("The application uses the Yandex.Schedules API")
                .font(AppConstants.fontRegular12)
            Text("Version 1.0 (beta)")
                .font(AppConstants.fontRegular12)
                .padding()
        }
    }
}

#Preview {
    SettingsView()
}
