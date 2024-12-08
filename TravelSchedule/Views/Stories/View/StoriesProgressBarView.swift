//
//  StoriesProgressBarView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 07.12.2024.
//

import SwiftUI
import Combine

struct StoriesProgressBarView: View {
    
    let storiesCount: Int
    @Binding var currentProgress: CGFloat
    let timerConfiguration: TimerConfiguration
    
    @State private var timer: Timer.TimerPublisher
    @State private var cancellable: Cancellable?
    
    init(storiesCount: Int, timerConfiguration: TimerConfiguration, currentProgress: Binding<CGFloat>) {
        self.storiesCount = storiesCount
        self.timerConfiguration = timerConfiguration
        self._currentProgress = currentProgress
        self.timer = Self.makeTimer(configuration: timerConfiguration)
    }
    
    var body: some View {
        ProgressBar(
            numberOfSections: storiesCount,
            progress: currentProgress
        )
        .padding(.top, Constants.progressBarPaddingTop)
        .padding(.horizontal, Constants.progressBarPaddingHorizontal)
        .onAppear {
            timer = Self.makeTimer(configuration: timerConfiguration)
            cancellable = timer.connect()
        }
        .onDisappear {
            cancellable?.cancel()
        }
        .onReceive(timer) { _ in
            timerTick()
        }
    }
}

extension StoriesProgressBarView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let progressBarPaddingTop: CGFloat = 20
        static let progressBarPaddingHorizontal: CGFloat = 12
    }
    
    // MARK: - timerTick
    
    private func timerTick() {
        withAnimation {
            currentProgress = timerConfiguration.nextProgress(progress: currentProgress)
        }
    }
    
    // MARK: - makeTimer
    
    private static func makeTimer(configuration: TimerConfiguration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
}

#Preview {
    let storiesCount = 3

    ZStack {
        Color(.lightGray)
            .ignoresSafeArea()
        StoriesProgressBarView(
            storiesCount: storiesCount,
            timerConfiguration: TimerConfiguration(storiesCount: storiesCount),
            currentProgress: .constant(0.5)
        )
    }
}
