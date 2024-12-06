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
    
    func swipe(
        up: @escaping (() -> Void) = {},
        down: @escaping (() -> Void) = {},
        left: @escaping (() -> Void) = {},
        right: @escaping (() -> Void) = {}
    ) -> some View {
        self.gesture(
            DragGesture(
                minimumDistance: 0,
                coordinateSpace: .local
            )
            .onEnded({ value in
                    if value.translation.width < 0 { left() }
                    if value.translation.width > 0 { right() }
                    if value.translation.height < 0 { up() }
                    if value.translation.height > 0 { down() }
                })
        )
    }
}
