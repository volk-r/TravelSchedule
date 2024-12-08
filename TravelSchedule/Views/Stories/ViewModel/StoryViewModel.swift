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
    
//    @Published var timer: Timer.TimerPublisher
    @Published var progress: CGFloat = 0
    
//    private var timerConfiguration: TimerConfiguration
//    private var stories: [StoryData]
//    private var currentStory: StoryData { stories[currentStoryIndex] }
//    private var currentStoryIndex: Int { Int(progress * CGFloat(stories.count)) }
//    
//    private var cancellable: Cancellable? = nil
//    
//    // MARK: - init
//    // TODO: 
//    init() {
//        self.stories = stories
//        timerConfiguration = TimerConfiguration(storiesCount: stories.count)
//        timer = Self.createTimer(configuration: timerConfiguration)
//    }
//    
//    func setupData(stories: [StoryData]) {
//        self.stories = stories
//        timerConfiguration = TimerConfiguration(storiesCount: stories.count)
//        timer = Self.createTimer(configuration: timerConfiguration)
//    }
//    
//    // MARK: - startTimer
//    
//    func startTimer() {
//        timer = Self.createTimer(configuration: timerConfiguration)
//        cancellable = timer.connect()
//    }
//    
//    // MARK: - stopTimer
//    
//    func stopTimer() {
//        cancellable?.cancel()
//    }
//    
//    // MARK: - getCurrentStory
//    
//    func getCurrentStory() -> StoryData {
//        currentStory
//    }
//    
//    // MARK: - resetTimer
//    
//    func resetTimer() {
//        stopTimer()
//        startTimer()
//    }
//    
//    // MARK: - nextStory
//    
//    func nextStory() {
//        let nextStoryIndex = timerConfiguration.nextIndex(for: progress)
//        progress = timerConfiguration.progress(for: nextStoryIndex)
//    }
//    
//    func prevStory() {
//        let prevIndex = timerConfiguration.prevIndex(for: progress)
//        progress = timerConfiguration.progress(for: prevIndex)
//    }
//    
//    // MARK: - getNumberOfSections
//    
//    func getNumberOfSections() -> Int {
//        stories.count
//    }
//    
//    func getCurrentStoryIndex() -> Int {
//        currentStoryIndex
//    }
//    
//    // MARK: - timerTick
//    
//    func timerTick() {
//        progress = timerConfiguration.nextProgress(progress: progress)
//    }
//    
//    // MARK: - createTimer
//    
//    private static func createTimer(configuration: TimerConfiguration) -> Timer.TimerPublisher {
//        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
//    }
}
