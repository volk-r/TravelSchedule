//
//  TravelScheduleTests.swift
//  TravelScheduleTests
//
//  Created by Roman Romanov on 31.10.2024.
//

import XCTest
import OpenAPIURLSession

@testable import TravelSchedule

final class TravelScheduleTests: XCTestCase {
    
    func getService() throws -> Client {
        Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
    }
    
    func testStationsListService() async throws {
        let service = StationsListService(
            client: try getService(),
            apikey: AppConstants.apiScheduleKey
        )
        
        let stations = try await service.getStationsList()
        print("stations: \(stations)")
        XCTAssertNotNil(stations.countries)
    }
    
    func testCarrierService() async throws {
//        let service = CarrierService(
//            client: try getService(),
//            apikey: AppConstants.apiScheduleKey
//        )
//        
//        let carriers = try await service.getCarriers(code: 100)
//        XCTAssertNotNil(carriers.carrier)
    }
}
