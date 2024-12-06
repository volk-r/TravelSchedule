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
        ZStack {
            backgroundView
            storiesProgressBar
            storiesContent
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
        static let textPaddingBottom: CGFloat = 40
        static let textColor: Color = .white
        
        static let progressBarPaddingTop: CGFloat = 20
        static let progressBarPaddingHorizontal: CGFloat = 12
        
        static let titleLineLimit: Int = 1
        static let titleFont: Font = AppConstants.fontBold34
        
        static let descriptionLineLimit: Int = 3
        static let descriptionFont: Font = AppConstants.fontRegular20
        
        static let storyCloseButtonImage: String = AppImages.storyCloseButton
        static let storyCloseButtonSize: CGFloat = 30
        static let storyCloseButtonRadius: CGFloat = 15
        static let storyCloseButtonPadding: CGFloat = -4
        static let storyCloseButtonPaddingTop: CGFloat = 47
        static let storyCloseButtonBackgroundColor: Color = Color(uiColor: UIColor(hexString: "#FFFFFF"))
        static let storyCloseButtonTintColor: Color = Color(uiColor: UIColor(hexString: "#1A1B22"))
    }
    
    // MARK: - backgroundView
    
    private var backgroundView: some View {
        Color(UIColor(hexString: model.getCurrentStory().backgroundColor.rawValue))
            .edgesIgnoringSafeArea(.all)
    }
    
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
    
    // MARK: - storiesContent
    
    private var storiesContent: some View {
        VStack(alignment: .leading) {
            closeButton
            Spacer()
            storyDescription
        }
        .padding(.horizontal)
        .padding(.bottom, Constants.textPaddingBottom)
    }
    
    // MARK: - closeButton
    
    private var closeButton: some View {
        HStack {
            Spacer()
            Button(action: { print("Close Story") } ) {
                Image(systemName: Constants.storyCloseButtonImage)
                    .resizable()
            }
            .tint(Constants.storyCloseButtonTintColor)
            .background(Constants.storyCloseButtonBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: Constants.storyCloseButtonRadius))
            .frame(
                width: Constants.storyCloseButtonSize,
                height: Constants.storyCloseButtonSize
            )
            .padding(.trailing, Constants.storyCloseButtonPadding)
            .padding(.top, Constants.storyCloseButtonPaddingTop)
        }
    }
    
    // MARK: - storyDescription
    
    private var storyDescription: some View {
        Group {
            Text(model.getCurrentStory().title)
                .font(Constants.titleFont)
                .lineLimit(Constants.titleLineLimit)
            Text(model.getCurrentStory().description)
                .font(Constants.descriptionFont)
                .lineLimit(Constants.descriptionLineLimit)
        }
        .foregroundColor(Constants.textColor)
    }
}

#Preview {
    StoryView()
}
