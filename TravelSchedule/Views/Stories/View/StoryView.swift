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
        storiesContent
            .background(
                backgroundView
            )
    }
}

extension StoryView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let textPaddingBottom: CGFloat = 40
        static let textColor: Color = .white
        
        static let titleLineLimit: Int = 1
        static let titleFont: Font = AppConstants.fontBold34
        
        static let descriptionLineLimit: Int = 3
        static let descriptionFont: Font = AppConstants.fontRegular20
    }
    
    // MARK: - backgroundView
    
    private var backgroundView: some View {
        Image(story.backgroundImage)
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
    }
    
    // MARK: - storiesContent
    
    private var storiesContent: some View {
        VStack(alignment: .leading) {
            Spacer()
            Group {
                Text(story.title)
                    .font(Constants.titleFont)
                    .lineLimit(Constants.titleLineLimit)
                Text(story.description)
                    .font(Constants.descriptionFont)
                    .lineLimit(Constants.descriptionLineLimit)
            }
            .foregroundColor(Constants.textColor)
        }
        .padding(.horizontal)
        .padding(.bottom, Constants.textPaddingBottom)
    }
}

#Preview {
    if let story = SelectStationViewModel().stories.last {
        StoryView(story: story)
    }
}
