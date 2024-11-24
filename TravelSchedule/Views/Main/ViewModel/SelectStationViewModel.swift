//
//  SelectStationViewModel.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 24.11.2024.
//

import Foundation

final class SelectStationViewModel: ObservableObject {
    @Published var fromStation: String = ""
    @Published var toStation: String = ""
    
    func changeStations() {
        let from = fromStation
        let to = toStation
        
        fromStation = to
        toStation = from
    }
    
    func findRoutes() {
        // TODO: 
    }
}
