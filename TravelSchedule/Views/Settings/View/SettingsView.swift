//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 26.11.2024.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appSettings: AppSettings
    
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
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
        .navigationDestination(isPresented: $viewModel.isUserAgreementPresented) {
            UserAgreementView(isShowRoot: $viewModel.isUserAgreementPresented)
        }
        .onAppear {
            self.viewModel.loadAppSetting(self.appSettings)
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
                    isOn: $viewModel.isDarkModeEnabled
                )
                .font(AppConstants.fontBold17)
                .tint(AppColorSettings.backgroundButtonColor)
                .padding(.bottom)
                .onChange(of: viewModel.isDarkModeEnabled) { isEnabled in
                    viewModel.setDarkMode(isEnabled: isEnabled)
                }
                
                Text("User agreement")
                    .font(AppConstants.fontBold17)
                    .badge(
                        Text("\(Image(systemName: AppImages.listBadge))")
                    )
                    .onTapGesture {
                        viewModel.isUserAgreementPresented = true
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
            Text(viewModel.appVersion)
                .font(AppConstants.fontRegular12)
                .padding()
        }
    }
}

#Preview {
    NavigationStack {    
        SettingsView()
            .environmentObject(AppSettings())
            .modifier(.colorScheme)
    }
}
