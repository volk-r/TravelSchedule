//
//  StoriesView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 06.12.2024.
//

import SwiftUI

struct StoriesView: View {
    
    // MARK: - Properties
    
    @Binding var stories: [StoryData]
    @Binding var showStory: Bool
    @Binding var currentStoryIndex: Int
    
    @StateObject private var model: StoriesViewModel
    
    // MARK: - init
    
    init(stories: Binding<[StoryData]>, showStory: Binding<Bool>, currentStoryIndex: Binding<Int>) {
        self._stories = stories
        self._showStory = showStory
        self._currentStoryIndex = currentStoryIndex
        
        let timerConfiguration: TimerConfiguration = TimerConfiguration(storiesCount: stories.count)
        self._model = StateObject(wrappedValue: StoriesViewModel(timerConfiguration: timerConfiguration))
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesTabView(stories: stories, currentStoryIndex: $currentStoryIndex)
                .onChange(of: currentStoryIndex) { newValue in
                    withAnimation {
                        model.saveStoryIndex(currentValue: currentStoryIndex, newValue: newValue)
                    }
                }
                .onTapGesture { location in
                    openNextStory(position: location.x)
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
                timerConfiguration: model.timerConfiguration,
                currentProgress: $model.currentProgress
            )
            .padding(.top, Constants.storyProgressBarTopPadding)
            .onChange(of: model.currentProgress) { newValue in
                withAnimation {
                    model.didChangeCurrentProgress(newProgress: newValue, currentStoryIndex: &currentStoryIndex)
                    
                    didStoryShowed()
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: Constants.storyCornerRadius))
        .padding(.top, Constants.storyTopPadding)
        .padding(.bottom, Constants.storyBottomPadding)
        .onAppear {
            withAnimation {
                model.saveStoryIndex(currentValue: currentStoryIndex, newValue: currentStoryIndex)
            }
        }
        .background(
            Constants.storyBackgroundColor
                .ignoresSafeArea(.all)
        )
        .toolbar(.hidden, for: .tabBar)
    }
}

extension StoriesView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let storyTopPadding: CGFloat = 7
        static let storyBottomPadding: CGFloat = 17
        static let storyCornerRadius: CGFloat = 40
        static let storyBackgroundColor: Color = Color(UIColor(hexString: "#1A1B22"))
        
        static let storyProgressBarTopPadding: CGFloat = 7
        
        static let closeButtonTrailingPadding: CGFloat = 12
        static let closeButtonTopPadding: CGFloat = 47
    }
    
    // MARK: - openNextStory
    
    private func openNextStory(position: CGFloat) {
        guard position > UIScreen.main.bounds.width / 2 else { return }
        
        if currentStoryIndex == stories.count - 1 {
            closeStory()
            return
        }
        
        model.nextStory(
            currentStoryIndex: currentStoryIndex,
            storiesCount: stories.count
        )
    }
    
    // MARK: - closeStory
    
    private func closeStory() {
        withAnimation(.easeInOut(duration: AppConstants.animationVelocity)) {
            showStory = false
        }
    }
    
    // MARK: - didStoryShowed
    
    private func didStoryShowed() {
        stories[currentStoryIndex].isShowed = true
        
        if isLastStoryShowed() {
            closeStory()
        }
    }
    
    // MARK: - isLastStoryShowed
    
    private func isLastStoryShowed() -> Bool {
        currentStoryIndex == stories.count - 1
        && model.currentProgress == 1.0
    }
}

#Preview {
    let stories = SelectStationViewModel().stories
    StoriesView(
        stories: .constant(stories),
        showStory: .constant(false),
        currentStoryIndex: .constant(0)
    )
}
