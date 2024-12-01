//
//  View+Extensions.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 28.11.2024.
//

import SwiftUI

extension View {
    func customPlaceholder(placeholder: some View, isVisible: Bool) -> some View {
        placeholder
            .opacity(isVisible ? 1 : 0)
            .font(AppConstants.fontBold24)
    }
    
    func backButtonToolbarItem(isShowRoot: Binding<Bool>) -> some View {
        self.toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { isShowRoot.wrappedValue.toggle() }) {
                    Image(systemName: AppImages.backButton)
                        .accentColor(AppColorSettings.fontColor)
                }
            }
        }
    }
}
