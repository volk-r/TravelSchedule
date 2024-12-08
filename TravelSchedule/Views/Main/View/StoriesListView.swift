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
                    StoryView(story: story)
                        .frame(
                            maxWidth: Constants.storyWidth,
                            maxHeight: Constants.storyHeight
                        )
                        .clipShape(RoundedRectangle(cornerRadius: Constants.storyCornerRadius))
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.5)) {   
                                showStory = true
                                selectedStory = story.id
                            }
                        }
                }
            }
        }
        .frame(maxHeight: Constants.storiesHeight)
        // TODO: board / opacity
//                .opacizty(viewInFinalState ? 1 : 0.5)
    }
}

extension StoriesListView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let storiesSpacing: CGFloat = 12
        static let storiesHeight: CGFloat = 188
        
        static let storyHeight: CGFloat = 140
        static let storyWidth: CGFloat = 92
        static let storyCornerRadius: CGFloat = 16
    }
}

#Preview {
    let stories = SelectStationViewModel().stories
    StoriesListView(stories: stories, showStory: .constant(true), selectedStory: .constant(1))
}
