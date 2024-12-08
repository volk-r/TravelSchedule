//
//  TimerConfiguration.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 06.12.2024.
//

import Foundation

struct TimerConfiguration {
    let storiesCount: Int
    let timerTickInternal: TimeInterval
    let progressPerTick: CGFloat

    init(
        storiesCount: Int,
        secondsPerStory: TimeInterval = 5,
        timerTickInternal: TimeInterval = 0.25
    ) {
        self.storiesCount = storiesCount
        self.timerTickInternal = timerTickInternal
        self.progressPerTick = 1.0 / CGFloat(storiesCount) / secondsPerStory * timerTickInternal
    }
}

extension TimerConfiguration {
    func progress(for storyIndex: Int) -> CGFloat {
        return min(CGFloat(storyIndex) / CGFloat(storiesCount), 1)
    }
    
    func nextIndex(for progress: CGFloat) -> Int {
        let currentIndex = index(for: progress)
        return (currentIndex + 1) % storiesCount
    }
    
    func prevIndex(for progress: CGFloat) -> Int {
        let currentIndex = index(for: progress)
        return (currentIndex - 1 + storiesCount) % storiesCount
    }

    func nextProgress(progress: CGFloat) -> CGFloat {
        return (progress + progressPerTick).truncatingRemainder(dividingBy: 1)
    }
    
    func index(for progress: CGFloat) -> Int {
        return min(Int(progress * CGFloat(storiesCount)), storiesCount - 1)
    }
}
