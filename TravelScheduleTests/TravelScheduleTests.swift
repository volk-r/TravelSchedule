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
        XCTAssertNotNil(stations.countries)
    }
    
    func testCarrierService() async throws {
        let service = CarrierService(
            client: try getService(),
            apikey: AppConstants.apiScheduleKey
        )
        
        let carriersCode = 680
        let carriers = try await service.getCarriers(code: carriersCode)
        XCTAssertEqual(carriers.carrier?.code, carriersCode, "Carrier code does not match")
    }
    
    func testCityService() async throws {
        let service = CityService(
            client: try getService(),
            apikey: AppConstants.apiScheduleKey
        )
        
        let city = try await service.getCity(lat: 50, lng: 40)
        XCTAssertEqual(city.title, "Митрофановка", "City title does not match")
    }
}
