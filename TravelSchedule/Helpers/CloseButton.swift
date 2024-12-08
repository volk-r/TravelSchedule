//
//  CloseButton.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 07.12.2024.
//

import SwiftUI

struct CloseButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: { withAnimation(.easeInOut(duration: 0.5)) { action() } }) {
            Image(systemName: Constants.buttonImage)
                .resizable()
        }
        .tint(Constants.buttonTintColor)
        .background(Constants.buttonBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: Constants.buttonCornerRadius))
        .frame(
            width: Constants.buttonSize,
            height: Constants.buttonSize
        )
    }
}

extension CloseButton {
    
    // MARK: - Constants
    
    private enum Constants {
        static let buttonImage: String = AppImages.storyCloseButton
        static let buttonSize: CGFloat = 30
        static let buttonCornerRadius: CGFloat = 15
        static let buttonBackgroundColor: Color = Color(uiColor: UIColor(hexString: "#FFFFFF"))
        static let buttonTintColor: Color = Color(uiColor: UIColor(hexString: "#1A1B22"))
    }
}

#Preview {
    CloseButton(action: {})
}
