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
    @EnvironmentObject private var selectStationViewModel: SelectStationViewModel
    
    @StateObject private var model: StoriesProgressBarViewModel = StoriesProgressBarViewModel()
    
    var body: some View {
        ProgressBar(
            numberOfSections: selectStationViewModel.stories.count,
            progress: storiesViewModel.currentProgress
        )
        .padding(.top, Constants.progressBarPaddingTop)
        .padding(.horizontal, Constants.progressBarPaddingHorizontal)
        .onAppear {
            model.setupTimer(timerConfiguration: storiesViewModel.timerConfiguration)
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
            guard let timerConfiguration = storiesViewModel.timerConfiguration else { return }
            storiesViewModel.currentProgress = timerConfiguration.nextProgress(progress: storiesViewModel.currentProgress)
        }
    }
}

#Preview {
    let storiesCount = 3
    
    ZStack {
        Color(.lightGray)
            .ignoresSafeArea()
        StoriesProgressBarView()
            .environmentObject(StoriesViewModel())
            .environmentObject(SelectStationViewModel())
    }
}
