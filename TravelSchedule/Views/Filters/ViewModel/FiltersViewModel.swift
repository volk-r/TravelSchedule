//
//  FiltersViewModel.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 10.12.2024.
//

import Foundation

@MainActor
final class FiltersViewModel: ObservableObject {
    @Published var isChecked: Bool = false
}
