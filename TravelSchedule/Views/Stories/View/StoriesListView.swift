//
//  StoriesListView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 07.12.2024.
//

import SwiftUI

struct StoriesListView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appSettings: AppSettings
    @EnvironmentObject private var selectStationViewModel: SelectStationViewModel
    
    private let rows = [GridItem(.flexible())]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, alignment: .center, spacing: Constants.storiesSpacing) {
                ForEach(selectStationViewModel.stories) { story in
                    StoryPreviewView(story: story)
                        .clipShape(RoundedRectangle(cornerRadius: Constants.storyCornerRadius))
                        .onTapGesture(coordinateSpace: .global) { location in
                            onTapAction(location: location, story: story)
                        }
                        .opacity(appSettings.isStoryShowed(story: story) ? 0.5 : 1)
                        .overlay(
                            storyBorder
                                .opacity(appSettings.isStoryShowed(story: story) ? 0 : 1)
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
    
    private func onTapAction(location: CGPoint, story: StoryData) {
        selectStationViewModel.chosenStoryPosition = location
        AnalyticService.trackClick(screen: .main, item: .openStories)
        
        withAnimation(.easeInOut(duration: AppConstants.animationVelocity)) {
            selectStationViewModel.showStory = true
            selectStationViewModel.storyToShowIndex = story.id
        }
    }
}

#Preview {
    StoriesListView()
        .environmentObject(AppSettings())
        .environmentObject(SelectStationViewModel())
}
