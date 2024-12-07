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
//            StoriesTabView(stories: <#T##[StoryData]#>, currentStoryIndex: <#T##Binding<Int>#>)
            SingleStoryView(story: model.getCurrentStory())
            CloseButton(action: { print("Close Story!") })
                .padding(.trailing, Constants.closeButtonTrailingPadding)
                .padding(.top, Constants.closeButtonTopPadding)
            
            storiesProgressBar
        }
        .onTapGesture {
            nextStory()
        }
        .swipe(
            left: {
                nextStory()
            },
            right: {
                model.resetTimer()
                model.prevStory()
            }
        )
    }
    
    private func nextStory() {
        model.resetTimer()
        model.nextStory()
    }
}

extension StoryView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let progressBarPaddingTop: CGFloat = 20
        static let progressBarPaddingHorizontal: CGFloat = 12
        
        static let closeButtonTrailingPadding: CGFloat = 12
        static let closeButtonTopPadding: CGFloat = 47
    }
    
    // MARK: - storiesProgressBar
    
    private var storiesProgressBar: some View {
        ProgressBar(
            numberOfSections: model.getNumberOfSections(),
            progress: model.progress
        )
        .padding(.top, Constants.progressBarPaddingTop)
        .padding(.horizontal, Constants.progressBarPaddingHorizontal)
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
}

#Preview {
    StoryView()
}
