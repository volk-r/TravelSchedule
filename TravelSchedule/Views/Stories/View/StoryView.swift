//
//  StoryView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 06.12.2024.
//

import SwiftUI

struct StoryView: View {
    
    // MARK: - Properties
    
    @StateObject private var model: StoryViewModel = StoryViewModel()
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            SingleStoryView(story: model.getCurrentStory())
                .onTapGesture {
                    nextStory()
                }
            
            CloseButton(action: { print("Close Story!") })
                .padding(.trailing, Constants.closeButtonTrailingPadding)
                .padding(.top, Constants.closeButtonTopPadding)
            
            StoriesProgressBarView(
                storiesCount: model.getNumberOfSections(),
                currentProgress: $model.progress
            )
            .onAppear{
                model.startTimer()
            }
            .onDisappear{
                model.stopTimer()
            }
            .onReceive(model.timer) { _ in
                withAnimation {
                    model.timerTick()
                }
            }
        }
        .swipe(
            left: {
                nextStory()
            },
            right: {
                withAnimation {
                    model.resetTimer()
                    model.prevStory()
                }
            }
        )
    }
    
    private func nextStory() {
        withAnimation {
            model.resetTimer()
            model.nextStory()
        }
    }
}

extension StoryView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let closeButtonTrailingPadding: CGFloat = 12
        static let closeButtonTopPadding: CGFloat = 47
    }
}

#Preview {
    StoryView()
}
