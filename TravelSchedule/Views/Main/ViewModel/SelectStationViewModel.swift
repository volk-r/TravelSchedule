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
    
    @Published var isFromStationPresented: Bool = false
    @Published var isToStationPresented: Bool = false
    
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
        // TODO: 
    }
}
