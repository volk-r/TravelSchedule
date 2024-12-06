//
//  StoryViewModel.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 06.12.2024.
//

import Foundation
import Combine

final class StoryViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var timer: Timer.TimerPublisher
    @Published var progress: CGFloat = 0
    
    private let configuration: Configuration
    
    private let stories: [StoryData]
    private var currentStory: StoryData { stories[currentStoryIndex] }
    private var currentStoryIndex: Int { Int(progress * CGFloat(stories.count)) }
    
    private var cancellable: Cancellable? = nil
    
    // MARK: - Configuration
    
    struct Configuration {
        let timerTickInternal: TimeInterval
        let progressPerTick: CGFloat
        
        init(
            storiesCount: Int,
            secondsPerStory: TimeInterval = 5,
            timerTickInternal: TimeInterval = 0.25
        ) {
            self.timerTickInternal = timerTickInternal
            self.progressPerTick = 1.0 / CGFloat(storiesCount) / secondsPerStory * timerTickInternal
        }
    }
    
    // MARK: - init
    
    init(stories: [StoryData] = [.story1, .story2, .story3]) {
        self.stories = stories
        configuration = Configuration(storiesCount: stories.count)
        
        timer = Self.createTimer(configuration: configuration)
    }
    
    // MARK: - startTimer
    
    func startTimer() {
        timer = Self.createTimer(configuration: configuration)
        cancellable = timer.connect()
    }
    
    // MARK: - stopTimer
    
    func stopTimer() {
        cancellable?.cancel()
    }
    
    // MARK: - getCurrentStory
    
    func getCurrentStory() -> StoryData {
        currentStory
    }
    
    // MARK: - resetTimer
    
    func resetTimer() {
        stopTimer()
        startTimer()
    }
    
    // MARK: - nextStory
    
    func nextStory() {
        let storiesCount = stories.count
        let currentStoryIndex = Int(progress * CGFloat(storiesCount))
        let nextStoryIndex = currentStoryIndex + 1 < storiesCount ? currentStoryIndex + 1 : 0
        progress = CGFloat(nextStoryIndex) / CGFloat(storiesCount)
    }
    
    // MARK: - getNumberOfSections
    
    func getNumberOfSections() -> Int {
        stories.count
    }
    
    // MARK: - timerTick
    
    func timerTick() {
        var nextProgress = progress + configuration.progressPerTick
        if nextProgress >= 1 {
            nextProgress = 0
        }
        progress = nextProgress
    }
    
    // MARK: - createTimer
    
    private static func createTimer(configuration: Configuration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
}
