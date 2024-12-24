//
//  StoryViewModel.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 06.12.2024.
//

import Foundation

@MainActor
final class StoriesViewModel: ObservableObject {
    
    // MARK: - Properties
        
    @Published var currentProgress: CGFloat = 0
    @Published var timerConfiguration: TimerConfiguration? = nil
    
    private var indexKeeper: Int = 0
    
    // MARK: - init
    
    init() {
        AnalyticService.trackOpenScreen(screen: .stories)
    }
    
    // MARK: - setupTimerConfiguration
    
    func setupTimerConfiguration(storiesCount: Int) {
        timerConfiguration = TimerConfiguration(storiesCount: storiesCount)
    }
    
    // MARK: - saveStoryIndex

    func saveStoryIndex(currentValue: Int, newValue: Int) {
        didChangeCurrentIndex(oldIndex: indexKeeper, newIndex: newValue)
        
        guard indexKeeper != currentValue else { return }
        indexKeeper = newValue
    }
    
    // MARK: - didChangeCurrentProgress
    
    func didChangeCurrentProgress(newProgress: CGFloat, currentStoryIndex: inout Int) {
        guard let timerConfiguration else { return }
        let index = timerConfiguration.index(for: newProgress)
        guard index != currentStoryIndex else { return }
        currentStoryIndex = index
    }
    
    // MARK: - nextStory
    
    func nextStory(currentStoryIndex: Int, storiesCount: Int) {
        indexKeeper = (currentStoryIndex + 1) % storiesCount
        didChangeCurrentIndex(oldIndex: currentStoryIndex, newIndex: indexKeeper)
    }
    
    // MARK: - didChangeCurrentIndex
    
    private func didChangeCurrentIndex(oldIndex: Int, newIndex: Int) {
        guard let timerConfiguration, oldIndex != newIndex else { return }
        let progress = timerConfiguration.progress(for: newIndex)
        guard abs(progress - currentProgress) >= 0.01 else { return }
        currentProgress = progress
    }
}
