//
//  Segment.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 30.11.2024.
//

import Foundation

struct CarrierMock: Hashable {
    let title: String
    let phone: String
    let logo: String
    let email: String
}

struct RouteCardData: Identifiable, Hashable, Sendable {

    // MARK: - Properties

    let id = UUID()
    let departureDate: Date
    let arrivalDate: Date
    let hasTransfers: Bool
    let transferTitle: String?
    let carrier: CarrierMock

    private var dateFormatter = DateFormatter()

    // MARK: - Init

    init(departureDate: Date, arrivalDate: Date, hasTransfers: Bool, transferTitle: String? = nil, carrier: CarrierMock) {
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
        dateFormatter.dateFormat = "d MMMM"
        return dateFormatter.string(from: departureDate)
    }

    func getDepartureTime() -> String {
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: departureDate)
    }

    func getDepartureHour() -> Int {
        return Calendar.current.component(.hour, from: departureDate)
    }

    func getArrivalTime() -> String {
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: arrivalDate)
    }

    func getDuration() -> Int {
        let delta = departureDate.distance(to: arrivalDate)
        let hours = Int(delta) / 3600
        return hours
    }
}
