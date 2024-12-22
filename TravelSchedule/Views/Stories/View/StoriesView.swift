//
//  StoriesView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 06.12.2024.
//

import SwiftUI

struct StoriesView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appSettings: AppSettings
    @EnvironmentObject private var selectStationViewModel: SelectStationViewModel
    
    var storiesCount: Int // TODO: how I can replace it to selectStationViewModel.stories.count, problem in StoriesViewModel.init -> timerConfiguration
    
    @StateObject private var model: StoriesViewModel
    
    // MARK: - init

    init(storiesCount: Int) {
        self.storiesCount = storiesCount
        let timerConfiguration: TimerConfiguration = TimerConfiguration(storiesCount: storiesCount)
        self._model = StateObject(wrappedValue: StoriesViewModel(timerConfiguration: timerConfiguration))
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesTabView()
                .onChange(of: selectStationViewModel.storyToShowIndex) { newValue in
                    withAnimation {
                        model.saveStoryIndex(currentValue: selectStationViewModel.storyToShowIndex, newValue: newValue)
                    }
                }
                .onTapGesture { location in
                    openNextStory(position: location.x)
                }
                .gesture(
                    DragGesture(minimumDistance: 30)
                        .onEnded { value in
                            if value.translation.height != 30 {
                                closeStory()
                            }
                        }
                )
            
            CloseButton(action: closeStory)
                .padding(.trailing, Constants.closeButtonTrailingPadding)
                .padding(.top, Constants.closeButtonTopPadding)
            
            StoriesProgressBarView(
                storiesCount: selectStationViewModel.stories.count,
                timerConfiguration: model.timerConfiguration
            )
            .environmentObject(model)
            .padding(.top, Constants.storyProgressBarTopPadding)
            .onChange(of: model.currentProgress) { newValue in
                withAnimation {
                    model.didChangeCurrentProgress(newProgress: newValue, currentStoryIndex: &selectStationViewModel.storyToShowIndex)
                    
                    didStoryShowed()
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: Constants.storyCornerRadius))
        .padding(.top, Constants.storyTopPadding)
        .padding(.bottom, Constants.storyBottomPadding)
        .onAppear {
            withAnimation {
                model.saveStoryIndex(currentValue: selectStationViewModel.storyToShowIndex, newValue: selectStationViewModel.storyToShowIndex)
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
        
        if selectStationViewModel.storyToShowIndex == selectStationViewModel.stories.count - 1 {
            closeStory()
            return
        }
        
        model.nextStory(
            currentStoryIndex: selectStationViewModel.storyToShowIndex,
            storiesCount: selectStationViewModel.stories.count
        )
    }
    
    // MARK: - closeStory
    
    private func closeStory() {
        AnalyticService.trackClick(screen: .stories, item: .closeStories)
        withAnimation(.easeInOut(duration: AppConstants.animationVelocity)) {
            selectStationViewModel.showStory = false
        }
    }
    
    // MARK: - didStoryShowed
    
    private func didStoryShowed() {
        appSettings.markAsShowed(story: selectStationViewModel.stories[selectStationViewModel.storyToShowIndex])
        
        let extraData: AnalyticsEventParams = ["storyId": selectStationViewModel.storyToShowIndex]
        AnalyticService.trackClick(screen: .stories, item: .showStory, extraData: extraData)
        
        if isLastStoryShowed() {
            closeStory()
        }
    }
    
    // MARK: - isLastStoryShowed
    
    private func isLastStoryShowed() -> Bool {
        selectStationViewModel.storyToShowIndex == selectStationViewModel.stories.count - 1
        && model.currentProgress == 1.0
    }
}

#Preview {
    let stories = SelectStationViewModel().stories
    StoriesView(storiesCount: stories.count)
        .environmentObject(SelectStationViewModel())
        .environmentObject(AppSettings())
}
