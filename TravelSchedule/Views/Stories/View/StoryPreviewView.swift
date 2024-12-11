//
//  StoryPreviewView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 10.12.2024.
//

import SwiftUI

struct StoryPreviewView: View {
    let story: StoryData
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack {
                Text(story.title)
                    .font(Constants.titleFont)
                    .lineLimit(Constants.titleLineLimit)
                    .foregroundColor(Constants.textColor)
                Spacer()
            }
        }
        .padding(.horizontal, Constants.titlePaddingHorizontal)
        .padding(.bottom, Constants.titlePaddingBottom)
        .frame(
            minWidth: Constants.storyWidth,
            maxWidth: Constants.storyWidth,
            minHeight: Constants.storyHeight,
            maxHeight: Constants.storyHeight
        )
        .background(
            StoryBackgroundView(image: story.backgroundImage)
        )
    }
}

extension StoryPreviewView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let textColor: Color = .white
        
        static let storyHeight: CGFloat = 140
        static let storyWidth: CGFloat = 92
        
        static let titleFont: Font = AppConstants.fontRegular12
        static let titlePaddingBottom: CGFloat = 12
        static let titlePaddingHorizontal: CGFloat = 8
        static let titleLineLimit: Int = 3
    }
}

#Preview {
    if let story = SelectStationViewModel().stories.last {
        StoryPreviewView(story: story)
    }
}
