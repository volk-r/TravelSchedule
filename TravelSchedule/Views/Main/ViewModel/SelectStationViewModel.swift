//
//  SelectStationViewModel.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 24.11.2024.
//

import Foundation

final class SelectStationViewModel: ObservableObject {
    @Published var isLoadingError: Bool = false
    
    @Published var fromStation: StationData = StationData(stationType: .from)
    @Published var toStation: StationData = StationData(stationType: .to)
    @Published var isFromStationPresented: Bool = false
    @Published var isToStationPresented: Bool = false
    
    @Published var isFindRoutesPresented: Bool = false
    
    @Published var stories: [StoryData] = [
        StoryData(
            id: 0,
            backgroundImage: "Story_1",
            title: "🎉 ⭐️ ❤️",
            description: "Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 ",
            isShowed: false
        ),
        StoryData(
            id: 1,
            backgroundImage: "Story_2",
            title: "😍 🌸 🥬",
            description: "Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 ",
            isShowed: false
        ),
        StoryData(
            id: 2,
            backgroundImage: "Story_3",
            title: "🧀 🥑 🥚",
            description: "Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 ",
            isShowed: true
        ),
        StoryData(
            id: 3,
            backgroundImage: "Story_4",
            title: "🔥🔥🔥",
            description: "Text Text Text Text Text Text Text Text Text",
            isShowed: true
        ),
        StoryData(
            id: 4,
            backgroundImage: "Story_5",
            title: "😨😱🥲",
            description: "Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 ",
            isShowed: true
        ),
        StoryData(
            id: 5,
            backgroundImage: "Story_6",
            title: "🚅🤔🤕",
            description: "Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 ",
            isShowed: true
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
    
    func findRoutes() {
        // TODO: disabled for development
//        guard let _ = fromStation.station, let _ = toStation.station else { return }
        isFindRoutesPresented = true
    }
}
