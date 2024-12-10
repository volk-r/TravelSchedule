//
//  StoriesListView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 07.12.2024.
//

import SwiftUI

struct StoriesListView: View {
    
    let stories: [StoryData]
    let rows = [GridItem(.flexible())]
    
    @Binding var showStory: Bool
    @Binding var selectedStory: Int
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, alignment: .center, spacing: Constants.storiesSpacing) {
                ForEach(stories) { story in
                    StoryPreviewView(story: story)
                        .clipShape(RoundedRectangle(cornerRadius: Constants.storyCornerRadius))
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                showStory = true
                                selectedStory = story.id
                            }
                        }
                        .opacity(story.isShowed ? 0.5 : 1)
                        .overlay(
                            storyBorder
                                .opacity(story.isShowed ? 0 : 1)
                        )
                }
            }
        }
        .frame(maxHeight: Constants.storiesHeight)
        .scrollIndicators(.never)
    }
}

extension StoriesListView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let storiesSpacing: CGFloat = 12
        static let storiesHeight: CGFloat = 188
        
        static let storyCornerRadius: CGFloat = 16
        static let storyBorderColor: Color = AppColorSettings.backgroundButtonColor
        static let storyBorderWidth: CGFloat = 4
    }
    
    // MARK: - storyBorder
    
    private var storyBorder: some View {
        RoundedRectangle(cornerRadius: Constants.storyCornerRadius)
            .strokeBorder(
                Constants.storyBorderColor,
                lineWidth: Constants.storyBorderWidth
            )
    }
}

#Preview {
    let stories = SelectStationViewModel().stories
    StoriesListView(
        stories: stories,
        showStory: .constant(true),
        selectedStory: .constant(1)
    )
}
