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
    @State private var path: [PathItem] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                AppColorSettings.backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    settingsList
                    Spacer()
                    copyright
                    Divider()
                }
            }
            .navigationDestination(for: PathItem.self) { id in
                if id == .userAgreement {
                    UserAgreementView()
                        .toolbar(.hidden, for: .tabBar)
                }
            }
        }
    }
}

extension SettingsView {
    
    // MARK: - PathItem
    
    private enum PathItem: CaseIterable {
        case userAgreement
    }
    
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
                
                Text("User agreement")
                    .font(AppConstants.fontBold17)
                    .badge(
                        Text("\(Image(systemName: "chevron.right"))")
                    )
                    .onTapGesture {
                        path.append(.userAgreement)
                    }
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
            Text("Version")
                .font(AppConstants.fontRegular12)
                .padding()
        }
    }
}

#Preview {
    SettingsView()
}
