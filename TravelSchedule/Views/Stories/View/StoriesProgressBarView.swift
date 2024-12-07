//
//  StoriesProgressBarView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 07.12.2024.
//

import SwiftUI

struct StoriesProgressBarView: View {
    
    let storiesCount: Int
    @Binding var currentProgress: CGFloat
    
    var body: some View {
        ProgressBar(
            numberOfSections: storiesCount,
            progress: currentProgress
        )
        .padding(.top, Constants.progressBarPaddingTop)
        .padding(.horizontal, Constants.progressBarPaddingHorizontal)
    }
}

extension StoriesProgressBarView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let progressBarPaddingTop: CGFloat = 20
        static let progressBarPaddingHorizontal: CGFloat = 12
    }
}

#Preview {
    let storiesCount = 3

    ZStack {
        Color(.lightGray)
            .ignoresSafeArea()
        StoriesProgressBarView(
            storiesCount: storiesCount,
            currentProgress: .constant(0.5)
        )
    }
}
