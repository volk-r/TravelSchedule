//
//  AnalyticItems.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 22.12.2024.
//

import Foundation

enum AnalyticItems: String, CaseIterable {
    case darkModeEnabled = "darkModeEnabled"
    case darkModeDisabled = "darkModeDisabled"
    case selectStation = "selectStation"
    case selectCity = "selectCity"
    case tapFiltersButton = "tapFiltersButton"
    case applyFilters = "applyFilters"
    case tapChangeStationButton = "tapChangeStationButton"
    case selectFromStation = "selectFromStation"
    case selectToStation = "selectToStation"
    case tapFindRoutesButton = "tapFindRoutesButton"
    case openStories = "openStories"
    case closeStories = "closeStories"
    case showStory = "showStory"
    case openCarrier = "openCarrier"
}
