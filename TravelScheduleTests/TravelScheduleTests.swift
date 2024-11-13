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
    
    private func getClient() throws -> Client {
        Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: AppConstants.apiScheduleKey)]
        )
    }
    
    func testStationsListService() async throws {
        let service = StationsListService(client: try getClient())
        let stations = try await service.getStationsList()
        XCTAssertNotNil(stations.countries, "Stations list not found")
    }
    
    func testCarrierService() async throws {
        let carriersCode = 680
        let service = CarrierService(client: try getClient())
        let carriers = try await service.getCarriers(code: carriersCode)
        XCTAssertEqual(carriers.carrier?.code, carriersCode, "Carrier code does not match")
    }
    
    func testCityService() async throws {
        let service = CityService(client: try getClient())
        let city = try await service.getCity(lat: 50, lng: 40)
        XCTAssertEqual(city.title, "Митрофановка", "City title does not match")
    }
    
    func testCopyrightService() async throws {
        let service = CopyrightService(client: try getClient())
        let copyright = try await service.getCopyright()
        XCTAssertEqual(copyright.copyright?.text?.contains("Яндекс.Расписания"), true, "Copyright does not match")
    }
    
    func testNearestStationsService() async throws {
        let service = NearestStationsService(client: try getClient())
        let stations = try await service.getNearestStations(lat: 59.864177, lng: 30.319163, distance: 1)
        XCTAssertNotNil(stations.stations, "Nearest Stations not found")
    }
    
    func testRouteService() async throws {
        let service = RouteService(client: try getClient())
        let route = try await service.getRoute(uid: "6296x6294x6292x6291_0_9613602_g24_4", stationCode: .all)
        XCTAssertNotNil(route.except_days, "Thread not found")
    }
    
    func testScheduleService() async throws {
        let service = ScheduleService(client: try getClient())
        let scheduleResponse = try await service.getSchedule(station: "s9613062")
        XCTAssertNotNil(scheduleResponse.schedule, "Schedule not found")
    }
    
    func testSearchRoutesService() async throws {
        let service = SearchRoutesService(client: try getClient())
        let searchResponse = try await service.searchRoutes(from: "s9613061", to: "s9613181")
        XCTAssertNotNil(searchResponse.pagination, "Search response has no pagination")
        XCTAssertNotNil(searchResponse.interval_segments, "Search response has no interval_segments")
        XCTAssertNotNil(searchResponse.segments, "Search response has no segments")
        XCTAssertNotNil(searchResponse.search, "Search response has no search data")
    }
}
