//
//  String+Extensions.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 19.12.2024.
//

import Foundation

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
}
