//
//  Segment.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 30.11.2024.
//

import Foundation

struct RouteCardData: Identifiable, Hashable, Sendable {
    
    // MARK: - Properties
    
    let id = UUID()
    let departureDate: Date
    let arrivalDate: Date
    let hasTransfers: Bool
    let transferTitle: String?
    let carrier: CarrierData
    
    private var dateFormatter = DateFormatterService.shared
    
    // MARK: - Identifiable (==)
    
    static func == (lhs: RouteCardData, rhs: RouteCardData) -> Bool {
        lhs.id == rhs.id
    }
    
    // MARK: - hash
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // MARK: - Init
    
    init(departureDate: Date, arrivalDate: Date, hasTransfers: Bool, transferTitle: String? = nil, carrier: CarrierData) {
        self.departureDate = departureDate
        self.arrivalDate = arrivalDate
        self.hasTransfers = hasTransfers
        self.transferTitle = transferTitle
        self.carrier = carrier
    }
    
    // MARK: - Methods
    
    func getTransferTitle() -> String? {
        if hasTransfers, let transferTitle = transferTitle {
            return String(localized: "With a transfer in") + " " + transferTitle
        } else {
            return nil
        }
    }
    
    func getDepartureDay() -> String {
        dateFormatter.stringFromDate(departureDate, inFormat: "d MMMM")
    }
    
    func getDepartureTime() -> String {
        dateFormatter.stringFromDate(departureDate, inFormat: "HH:mm")
    }
    
    func getDepartureHours() -> Int {
        return Calendar.current.component(.hour, from: departureDate)
    }
    
    func getArrivalTime() -> String {
        dateFormatter.stringFromDate(arrivalDate, inFormat: "HH:mm")
    }
    
    func getDuration() -> Int {
        let delta = departureDate.distance(to: arrivalDate)
        let hours = Int(delta) / 3600
        return hours
    }
}
