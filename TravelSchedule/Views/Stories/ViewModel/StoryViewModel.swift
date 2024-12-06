//
//  StoryViewModel.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 06.12.2024.
//

import Foundation
import Combine

final class StoryViewModel: ObservableObject {
    @Published var timer: Timer.TimerPublisher
    @Published var currentStory: StoryData
    @Published var progress: CGFloat = 0
    
    private let configuration: Configuration
    private let stories: [StoryData]
    private var currentStoryIndex: Int { Int(progress * CGFloat(stories.count)) }
    
    private var cancellable: Cancellable? = nil
    
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
    
    init(stories: [StoryData] = [.story1, .story2, .story3]) {
        self.stories = stories
        configuration = Configuration(storiesCount: stories.count)
        
        timer = Self.createTimer(configuration: configuration)
        currentStory = stories[stories.startIndex]
    }
    
    func startTimer() {
        timer = Self.createTimer(configuration: configuration)
        cancellable = timer.connect()
    }
    
    func stopTimer() {
        cancellable?.cancel()
    }
    
    func resetTimer() {
        stopTimer()
        startTimer()
    }
    
    func nextStory() {
        let nextStoryIndex = currentStoryIndex + 1 < stories.count ? currentStoryIndex + 1 : 0
        progress = CGFloat(nextStoryIndex) / CGFloat(currentStoryIndex)
        currentStory = stories[nextStoryIndex]
    }
    
    func getNumberOfSections() -> Int {
        stories.count
    }
    
    func timerTick() {
        var nextProgress = progress + configuration.progressPerTick
        if nextProgress >= 1 {
            nextProgress = 0
        }
        progress = nextProgress
    }
    
    private static func createTimer(configuration: Configuration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
}
