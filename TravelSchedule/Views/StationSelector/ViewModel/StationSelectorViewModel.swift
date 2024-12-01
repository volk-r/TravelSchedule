//
//  StationSelectorViewModel.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 01.12.2024.
//

import Foundation

final class StationSelectorViewModel: ObservableObject {
    func selectStation(station: String, withStationData stationData: inout String) {
        stationData = station
    }
}
