//
//  StoryBackgroundView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 10.12.2024.
//

import SwiftUI

struct StoryBackgroundView: View {
    let image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    if let story = SelectStationViewModel().stories.last {
        StoryBackgroundView(image: story.backgroundImage)
    }
}
