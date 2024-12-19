//
//  RouteSelectionListViewModel.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 01.12.2024.
//

import Foundation

@MainActor
final class RouteSelectionListViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var isLoading: Bool = false
    @Published var isError: NetworkErrorType? = nil
    @Published var allRoutes: [RouteCardData] = []
    
    @Published var isFiltersPagePresented: Bool = false
    
    private let networkService: some NetworkServiceProtocol = NetworkService()
    private let isoDateFormatter = ISO8601DateFormatter()
    
    init () {
        isoDateFormatter.formatOptions = [
            .withFullDate,
            .withTime,
            .withDashSeparatorInDate,
            .withColonSeparatorInTime
        ]
    }
    
    // MARK: - openFiltersPage
    
    func openFiltersPage() {
        isFiltersPagePresented.toggle()
    }
    
    func getPageTitleFor(routes: RouteData) -> String {
        (routes.fromStation.station?.name ?? "") + " → " + (routes.toStation.station?.name ?? "")
    }
    
    // MARK: - fetchRoutes
    
    func fetchRoutesAlong(way routes: RouteData) async {
        await MainActor.run {
            isLoading = true
            isError = nil
        }
        
        guard
            let fromStationId = routes.fromStation.station?.id,
            let toStationId = routes.toStation.station?.id
        else {
            await MainActor.run {
                isLoading = false
                isError = .serverError
            }
            return
        }
        
        var searchResponse: SearchResponse
        
        // TODO: need to setup filters from Filters screen
        
        do {
            searchResponse = try await networkService.searchRoutes(from: fromStationId, to: toStationId, date: nil, hasTransfers: true)
        }
        catch {
            await MainActor.run {
                isLoading = false
                isError = .noInternetConnection
            }
            return
        }
        
        guard let segments = searchResponse.segments else {
            await MainActor.run {
                isLoading = false
                isError = .serverError
            }
            return
        }
        
        var routes: [RouteCardData] = []
        
        segments.forEach{ segment in
            let dateString: String = "\(segment.start_date ?? "")T\(segment.departure ?? "")"
            guard let departureDate: Date = isoDateFormatter.date(from: dateString) else { return }
            
            let hasTransfers = segment.has_transfers ?? false
            
            routes.append(
                RouteCardData(
                    departureDate: departureDate,
                    arrivalDate: departureDate.addingTimeInterval(TimeInterval(segment.duration ?? 0)),
                    hasTransfers: hasTransfers,
                    transferTitle: hasTransfers ? "Yes" : "NO",// TODO: need to find route with Transfer
                    // TODO: need to get Carrier info from Network via addTask
                    carrier: CarrierMock(
                        title: segment.thread?.carrier?.title ?? "",
                        phone: segment.thread?.carrier?.phone ?? "",
                        logo: segment.thread?.carrier?.logo ?? "",
                        email: segment.thread?.carrier?.email ?? ""
                    )
                )
            )
        }
        
        await MainActor.run { [routes] in
            allRoutes = routes
            isLoading = false
            isError = nil
        }
    }
}
