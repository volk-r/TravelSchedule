//
//  StoriesProgressBarViewModel.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 08.12.2024.
//

import Foundation
import Combine

final class StoriesProgressBarViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var timer: Timer.TimerPublisher
    
    private var timerConfiguration: TimerConfiguration
    private var cancellable: Cancellable? = nil
    
    // MARK: - init
    
    init(timerConfiguration configuration: TimerConfiguration) {
        timerConfiguration = configuration
        timer = Self.createTimer(configuration: timerConfiguration)
    }
    
    // MARK: - startTimer

    func startTimer() {
        timer = Self.createTimer(configuration: timerConfiguration)
        cancellable = timer.connect()
    }

    // MARK: - stopTimer

    func stopTimer() {
        cancellable?.cancel()
    }

    // MARK: - resetTimer

    func resetTimer() {
        stopTimer()
        startTimer()
    }

    // MARK: - timerTick

    func timerTick(progress: CGFloat) -> CGFloat {
        timerConfiguration.nextProgress(progress: progress)
    }
    
    // MARK: - createTimer
    
    private static func createTimer(configuration: TimerConfiguration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
}
