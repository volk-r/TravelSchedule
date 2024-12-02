//
//  FiltersView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 28.11.2024.
//

import SwiftUI

struct FiltersView: View {
    
    // MARK: - Properties
    
    @Binding var isShowRoot: Bool

    @State private var isChecked: Bool = false
    
    var body: some View {
        ZStack {
            AppColorSettings.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: Constants.defaultSpacing) {
                departureTimeView
                transfersView
                    .safeAreaInset(edge: .bottom) {
                        applyButton
                    }
            }
        }
        .navigationBarBackButtonHidden()
        .backButtonToolbarItem(isShowRoot: $isShowRoot)
    }
}

extension FiltersView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let defaultSpacing: CGFloat = 16
        static let defaultRowHeight: CGFloat = 60
        static let optionsListHeight: CGFloat = defaultRowHeight * 4
        static let applyButtonHeight: CGFloat = 60
        static let applyButtonTextColor: Color = .white
    }
    
    // MARK: - departureTimeView
    
    private var departureTimeView: some View {
        VStack(alignment: .leading) {
            Text(TimeOfDay.title)
                .font(AppConstants.fontBold24)
                .padding()
            
            List(TimeOfDay.allCases) { param in
                VStack {
                    Toggle(isOn: $isChecked) {
                        Text(param.description)
                            .font(AppConstants.fontRegular17)
                    }
                    .toggleStyle(.checkmark)
                }
                .frame(height: Constants.defaultRowHeight)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
            .frame(height: Constants.optionsListHeight)
            .padding(.horizontal)
        }
    }
    
    // MARK: - transfersView
    
    private var transfersView: some View {
        VStack(alignment: .leading) {
            Text(TransferOption.title)
                .font(AppConstants.fontBold24)
                .padding()
            List(TransferOption.allCases) { param in
                VStack {
                    Toggle(isOn: $isChecked) {
                        Text(param.description)
                            .font(AppConstants.fontRegular17)
                    }
                    .toggleStyle(.radioButton)
                }
                .frame(height: Constants.defaultRowHeight)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
            .frame(height: Constants.optionsListHeight)
            .padding(.horizontal)
        }
    }
    
    private var applyButton: some View {
        Button(
            action: {
                applyButtonTap()
            },
            label: {
                Text("Apply")
                    .frame(
                        maxWidth: .infinity,
                        minHeight: Constants.applyButtonHeight
                    )
                    .font(AppConstants.fontBold17)
            }
        )
        .background(AppColorSettings.backgroundButtonColor)
        .foregroundStyle(Constants.applyButtonTextColor)
        .clipShape(RoundedRectangle(cornerRadius: AppConstants.defaultCornerRadius))
        .padding(.horizontal)
        .opacity(isChecked ? 1 : 0)
    }
    
    private func applyButtonTap() {
        // TODO: save parameters in the future
        isShowRoot.toggle()
    }
}

final class FiltersViewPreview: ObservableObject {
    @State var isShowRoot: Bool = true
}

#Preview {
    let params = FiltersViewPreview()
    FiltersView(isShowRoot: params.$isShowRoot)
}
