//
//  StoriesTabView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 08.12.2024.
//

import SwiftUI

struct StoriesTabView: View {
    
    @EnvironmentObject private var selectStationViewModel: SelectStationViewModel
    
    var body: some View {
        TabView(selection: $selectStationViewModel.storyToShowIndex) {
            ForEach(selectStationViewModel.stories) { story in
                StoryView(story: story)
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

#Preview {
    StoriesTabView()
        .environmentObject(SelectStationViewModel())
}
