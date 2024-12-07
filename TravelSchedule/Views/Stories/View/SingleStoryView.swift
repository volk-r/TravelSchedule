//
//  SingleStoryView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 07.12.2024.
//

import SwiftUI

struct SingleStoryView: View {
    let story: StoryData
    
    var body: some View {
        ZStack {
            backgroundView
            storiesContent
        }
    }
}

extension SingleStoryView {
    
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
        Color(UIColor(hexString: story.backgroundColor.rawValue))
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

#Preview("StoriesTabView") {
    let stories: [StoryData] = [.story1, .story2, .story3]
    StoriesTabView(stories: stories, currentStoryIndex: .constant(1))
}

#Preview {
    SingleStoryView(story: StoryData.story3)
}
