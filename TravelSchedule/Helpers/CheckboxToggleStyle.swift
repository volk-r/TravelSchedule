//
//  CheckboxToggleStyle.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 29.11.2024.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(
        configuration: Configuration
    ) -> some View {
        HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn
                  ? AppImages.checkboxChecked
                  : AppImages.checkboxUnchecked
            )
            .resizable()
            .frame(width: 24, height: 24)
        }
        .onTapGesture {
            withAnimation(.spring()) {
                configuration.isOn.toggle()
            }
        }
    }
}

#Preview {
    FiltersView()
}
