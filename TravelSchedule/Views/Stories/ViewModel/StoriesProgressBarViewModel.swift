//
//  StoriesProgressBarViewModel.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 08.12.2024.
//

import Foundation
import Combine

@MainActor
final class StoriesProgressBarViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var timer: Timer.TimerPublisher = Timer.publish(every: 0, on: .main, in: .common)
    
    private var timerConfiguration: TimerConfiguration? = nil
    private var cancellable: Cancellable? = nil
    
    // MARK: - setupTimer
    
    func setupTimer(timerConfiguration configuration: TimerConfiguration?) {
        guard let configuration else { return }
        timerConfiguration = configuration
        timer = Self.createTimer(configuration: configuration)
    }
    
    // MARK: - startTimer

    func startTimer() {
        guard let timerConfiguration else { return }
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
        timerConfiguration?.nextProgress(progress: progress) ?? 0
    }
    
    // MARK: - createTimer
    
    private static func createTimer(configuration: TimerConfiguration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
}
