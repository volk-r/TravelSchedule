//
//  StoriesTabView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 07.12.2024.
//

import SwiftUI

struct StoriesTabView: View {
    let stories: [StoryData]
    @Binding var currentStoryIndex: Int

    var body: some View {
        TabView(selection: $currentStoryIndex) {
            ForEach(stories) { story in
                SingleStoryView(story: story)
                    .onTapGesture {
                        didTapStory()
                    }
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }

    func didTapStory() {
        // TODO: 
//        currentStoryIndex = min(currentStoryIndex + 1, stories.count - 1)
        currentStoryIndex = (currentStoryIndex + 1) % stories.count
//        currentStoryIndex = 2
//        print("stories.count - 1:", stories.count - 1)
        print("currentStoryIndex:", currentStoryIndex)
    }
}

#Preview {
    let stories: [StoryData] = [.story1, .story2, .story3]
    StoriesTabView(stories: stories, currentStoryIndex: .constant(0))
}
