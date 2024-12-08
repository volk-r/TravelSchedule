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
            backgroundColor: .firstPage,
            title: "🎉 ⭐️ ❤️",
            description: "Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 "
        ),
        StoryData(
            id: 1,
            backgroundColor: .secondPage,
            title: "😍 🌸 🥬",
            description: "Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 "
        ),
        StoryData(
            id: 2,
            backgroundColor: .thirdPage,
            title: "🧀 🥑 🥚",
            description: "Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 "
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
        isFindRoutesPresented = true
    }
}
