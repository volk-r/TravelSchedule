//
//  RouteSelectionListViewModel.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 01.12.2024.
//

import Foundation

final class RouteSelectionListViewModel: ObservableObject {
    @Published var isFiltersPagePresented: Bool = false
    
    func openFiltersPage() {
        isFiltersPagePresented.toggle()
    }
}
