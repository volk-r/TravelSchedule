//
//  StoriesTabView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 08.12.2024.
//

import SwiftUI

struct StoriesTabView: View {
    
    let stories: [StoryData]
    @Binding var currentStoryIndex: Int
    
    var body: some View {
        TabView(selection: $currentStoryIndex) {
            ForEach(stories) { story in
                StoryView(story: story)
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

#Preview {
    let stories = SelectStationViewModel().stories
    StoriesTabView(stories: stories, currentStoryIndex: .constant(0))
}
