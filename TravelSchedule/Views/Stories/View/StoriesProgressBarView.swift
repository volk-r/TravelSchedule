//
//  StoriesProgressBarView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 07.12.2024.
//

import SwiftUI

struct StoriesProgressBarView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var storiesViewModel: StoriesViewModel
    
    // TODO: how I can replace it to selectStationViewModel.stories.count, problem in StoriesProgressBarViewModel.init -> timerConfiguration
    let storiesCount: Int
    let timerConfiguration: TimerConfiguration

    @StateObject private var model: StoriesProgressBarViewModel
    
    // MARK: - init
    
    init(storiesCount: Int, timerConfiguration: TimerConfiguration) {
        self.storiesCount = storiesCount
        self.timerConfiguration = timerConfiguration
        self._model = StateObject(wrappedValue: StoriesProgressBarViewModel(timerConfiguration: timerConfiguration))
    }
    
    var body: some View {
        ProgressBar(
            numberOfSections: storiesCount,
            progress: storiesViewModel.currentProgress
        )
        .padding(.top, Constants.progressBarPaddingTop)
        .padding(.horizontal, Constants.progressBarPaddingHorizontal)
        .onAppear {
            model.startTimer()
        }
        .onDisappear {
            model.stopTimer()
        }
        .onReceive(model.timer) { _ in
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
            storiesViewModel.currentProgress = timerConfiguration.nextProgress(progress: storiesViewModel.currentProgress)
        }
    }
}

#Preview {
    let storiesCount = 3

    ZStack {
        Color(.lightGray)
            .ignoresSafeArea()
        StoriesProgressBarView(
            storiesCount: storiesCount,
            timerConfiguration: TimerConfiguration(storiesCount: storiesCount)
        )
        .environmentObject(StoriesViewModel(timerConfiguration: TimerConfiguration(storiesCount: storiesCount)))
    }
}
