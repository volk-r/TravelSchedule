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
    
    let travelSchedule = TravelScheduleApp()
    
    func testStationsListService() async throws {
        let stations = try await travelSchedule.getStationsList()
        XCTAssertNotNil(stations.countries, "Stations list not found")
    }
    
    func testCarrierService() async throws {
        let carriersCode = 680
        let carriers = try await travelSchedule.getCarriers(code: carriersCode)
        XCTAssertEqual(carriers.carrier?.code, carriersCode, "Carrier code does not match")
    }
    
    func testCityService() async throws {
        let city = try await travelSchedule.getCity(lat: 50, lng: 40)
        XCTAssertEqual(city.title, "Митрофановка", "City title does not match")
    }
    
    func testCopyrightService() async throws {
        let copyright = try await travelSchedule.getCopyright()
        XCTAssertEqual(copyright.copyright?.text?.contains("Яндекс.Расписания"), true, "Copyright does not match")
    }
    
    func testNearestStationsService() async throws {
        let stations = try await travelSchedule.getNearestStations(lat: 59.864177, lng: 30.319163, distance: 1)
        XCTAssertNotNil(stations.stations, "Nearest Stations not found")
    }
    
    func testRouteService() async throws {
        let route = try await travelSchedule.getRoute(uid: "6296x6294x6292x6291_0_9613602_g24_4", stationCode: .all)
        XCTAssertNotNil(route.except_days, "Thread not found")
    }
    
    func testScheduleService() async throws {
        let scheduleResponse = try await travelSchedule.getSchedule(station: "s9613062")
        XCTAssertNotNil(scheduleResponse.schedule, "Schedule not found")
    }
    
    func testSearchRoutesService() async throws {
        let searchResponse = try await travelSchedule.searchRoutes(from: "s9613061", to: "s9613181")
        XCTAssertNotNil(searchResponse.pagination, "Search response has no pagination")
        XCTAssertNotNil(searchResponse.interval_segments, "Search response has no interval_segments")
        XCTAssertNotNil(searchResponse.segments, "Search response has no segments")
        XCTAssertNotNil(searchResponse.search, "Search response has no search data")
    }
}
