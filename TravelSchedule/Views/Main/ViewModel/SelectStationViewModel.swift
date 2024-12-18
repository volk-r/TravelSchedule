//
//  SelectStationViewModel.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 24.11.2024.
//

import Foundation

@MainActor
final class SelectStationViewModel: ObservableObject {
    @Published var isLoadingError: Bool = false
    
    @Published var fromStation: StationData = StationData(stationType: .from)
    @Published var toStation: StationData = StationData(stationType: .to)
    @Published var isFromStationPresented: Bool = false
    @Published var isToStationPresented: Bool = false
    
    @Published var isFindRoutesPresented: Bool = false
    
    @Published var storyToShowIndex: Int = 0
    @Published var showStory: Bool = false
    @Published var chosenStoryPosition: CGPoint = .zero
    
    @Published var stories: [StoryData] = [
        StoryData(
            id: 0,
            backgroundImage: "Story_1",
            title: "🎉 ⭐️ ❤️",
            description: Array(repeating: "Text1", count: 20).joined(separator: " ")
        ),
        StoryData(
            id: 1,
            backgroundImage: "Story_2",
            title: "😍 🌸 🥬",
            description: Array(repeating: "Text2", count: 20).joined(separator: " ")
        ),
        StoryData(
            id: 2,
            backgroundImage: "Story_3",
            title: "🧀 🥑 🥚",
            description: Array(repeating: "Text3", count: 15).joined(separator: " ")
        ),
        StoryData(
            id: 3,
            backgroundImage: "Story_4",
            title: "🔥🔥🔥",
            description: Array(repeating: "Text4", count: 10).joined(separator: " ")
        ),
        StoryData(
            id: 4,
            backgroundImage: "Story_5",
            title: "😨😱🥲",
            description: Array(repeating: "Text5", count: 20).joined(separator: " ")
        ),
        StoryData(
            id: 5,
            backgroundImage: "Story_6",
            title: "🚅🤔🤕",
            description: Array(repeating: "Text6", count: 16).joined(separator: " ")
        )
    ]
    
    func changeStations() {
        let from = fromStation
        let to = toStation
        
        fromStation = to
        toStation = from
    }
    
    func selectFromStation() {
        isFromStationPresented = true
    }
    
    func selectToStation() {
        isToStationPresented = true
    }
    
    func isStationsSelected() -> Bool {
        guard let _ = fromStation.station, let _ = toStation.station else { return false }
        return true
    }
    
    func findRoutes() {
        guard isStationsSelected() else { return }
        isFindRoutesPresented = true
    }
}
