//
//  FiltersViewModel.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 10.12.2024.
//

import Foundation

@MainActor
final class FiltersViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var withTransfers: TransferOption? = nil
    @Published var filters: Filters?
    
    // MARK: - setup

    func setup(filters: Filters) {
        self.filters = filters
        
        if let withTransfers = filters.withTransfers {
            self.withTransfers = withTransfers == true ? .yes : .no
        }
    }
    
    // MARK: - applyFilters
    
    func applyFilters(_ filters: inout Filters) {
        filters.withTransfers = withTransfers == .yes ? true : false
    }
    
    // MARK: - isFilterSelected
    
    func isFilterSelected() -> Bool {
        withTransfers != nil
    }
}
