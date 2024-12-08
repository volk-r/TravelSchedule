//
//  StoryView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 06.12.2024.
//

import SwiftUI

struct StoryView: View {
    
    // MARK: - Properties
    
    let stories: [StoryData]
    @Binding var showStory: Bool
    @Binding var currentStoryIndex: Int
    // TODO:
    //    @StateObject private var model: StoryViewModel = StoryViewModel()
    
    @State private var indexKeeper: Int = 0
    @State private var currentProgress: CGFloat = 0
    
    private var timerConfiguration: TimerConfiguration { .init(storiesCount: stories.count) }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesTabView(stories: stories, currentStoryIndex: $currentStoryIndex)
                .onChange(of: currentStoryIndex) {
                    didChangeCurrentIndex(oldIndex: indexKeeper, newIndex: $0)
                    if indexKeeper != currentStoryIndex {
                        indexKeeper = $0
                    }
                }
                .onTapGesture {
                    nextStory()
                }
                .gesture(
                    DragGesture(minimumDistance: 30)
                        .onEnded { value in
                            if
                                value.translation.height < 30
                                || value.translation.height > 30
                            {
                                closeStory()
                            }
                        }
                )
            
            CloseButton(action: closeStory)
                .padding(.trailing, Constants.closeButtonTrailingPadding)
                .padding(.top, Constants.closeButtonTopPadding)
            
            StoriesProgressBarView(
                storiesCount: stories.count,
                timerConfiguration: timerConfiguration,
                currentProgress: $currentProgress
            )
            .onChange(of: currentProgress) {
                didChangeCurrentProgress(newProgress: $0)
            }
        }
        .onAppear {
            didChangeCurrentIndex(oldIndex: indexKeeper, newIndex: currentStoryIndex)
            if indexKeeper != currentStoryIndex {
                indexKeeper = currentStoryIndex
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
    
    private func didChangeCurrentIndex(oldIndex: Int, newIndex: Int) {
        guard oldIndex != newIndex else { return }
        let progress = timerConfiguration.progress(for: newIndex)
        guard abs(progress - currentProgress) >= 0.01 else { return }
        withAnimation {
            currentProgress = progress
        }
    }
    
    private func didChangeCurrentProgress(newProgress: CGFloat) {
        let index = timerConfiguration.index(for: newProgress)
        guard index != currentStoryIndex else { return }
        withAnimation {
            currentStoryIndex = index
        }
    }
    
    private func nextStory() {
        indexKeeper = (currentStoryIndex + 1) % stories.count
        didChangeCurrentIndex(oldIndex: currentStoryIndex, newIndex: indexKeeper)
    }
    
    private func closeStory() {
        withAnimation(.easeInOut(duration: 0.5)) {
            showStory = false
        }
    }
}

extension StoryView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let closeButtonTrailingPadding: CGFloat = 12
        static let closeButtonTopPadding: CGFloat = 47
    }
}

#Preview {
    let stories = SelectStationViewModel().stories
    StoryView(
        stories: stories,
        showStory: .constant(false),
        currentStoryIndex: .constant(0)
    )
}
