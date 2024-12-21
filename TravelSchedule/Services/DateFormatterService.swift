//
//  DateFormatterService.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 21.12.2024.
//

import Foundation

final class DateFormatterService: @unchecked Sendable {
    static let shared = DateFormatterService()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        return formatter
    }()
    
    private lazy var formatterISO: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withFullDate,
            .withTime,
            .withDashSeparatorInDate,
            .withColonSeparatorInTime
        ]
        return formatter
    }()
    
    private init() { }
    
    func formatISOStringToDate(_ dateString: String?) -> Date? {
        guard let dateString = dateString else { return nil }
        return formatterISO.date(from: dateString)
    }
    
    func stringFromDate(_ date: Date, inFormat format: String) -> String {
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}
