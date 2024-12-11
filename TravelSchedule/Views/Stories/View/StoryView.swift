//
//  StoryView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 07.12.2024.
//

import SwiftUI

struct StoryView: View {
    let story: StoryData
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Group {
                Text(story.title)
                    .font(Constants.titleFont)
                    .lineLimit(Constants.titleLineLimit)
                    .padding(.bottom, Constants.titlePaddingBottom)
                Text(story.description)
                    .font(Constants.descriptionFont)
                    .lineLimit(Constants.descriptionLineLimit)
            }
            .foregroundColor(Constants.textColor)
        }
        .padding(.horizontal)
        .padding(.bottom, Constants.textPaddingBottom)
        .background(
            StoryBackgroundView(image: story.backgroundImage)
        )
    }
}

extension StoryView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let textPaddingBottom: CGFloat = 40
        static let titlePaddingBottom: CGFloat = 16
        static let textColor: Color = .white
        
        static let titleLineLimit: Int = 1
        static let titleFont: Font = AppConstants.fontBold34
        
        static let descriptionLineLimit: Int = 3
        static let descriptionFont: Font = AppConstants.fontRegular20
    }
}

#Preview {
    if let story = SelectStationViewModel().stories.last {
        StoryView(story: story)
    }
}
