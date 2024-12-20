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
    
    private let networkService = NetworkService()
    private let isoDateFormatter = ISO8601DateFormatter()// TODO: need singletone ! ! !
    
    private let carrierInfoDownloader = CarrierInfoDownloader()
    
    // MARK: - init
    
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
    
    // MARK: - getPageTitleFor
    
    func getPageTitleFor(routes: RouteData) -> String {
        (routes.fromStation.station?.name ?? "") + " → " + (routes.toStation.station?.name ?? "")
    }
    
    // MARK: - fetchRoutesAlong
    
    func fetchRoutesAlong(way routes: RouteData) async {
        await MainActor.run {
            isLoading = true
            isError = nil
        }
        
        guard
            let fromStationId = routes.fromStation.station?.id,
            let toStationId = routes.toStation.station?.id
        else {
            await MainActor.run { setError(errorType: .serverError) }
            return
        }
        
        // TODO: need to setup filters from Filters screen
        
        let routeSegments: RouteSegments
        do {
            routeSegments = try await getRouteSegments(
                fromStationId: fromStationId,
                toStationId: toStationId
            )
        }
        catch {
            await MainActor.run { setError(errorType: .noInternetConnection) }
            return
        }
        
        let routes: [RouteCardData] = await populateRoutesData(routeSegments: routeSegments)
        
        if isError != nil {
            return
        }
        
        await MainActor.run { [routes] in
            allRoutes = routes
            allRoutes.sort{ $0.departureDate < $1.departureDate }
            isLoading = false
            isError = nil
        }
    }
    
    // MARK: - populateRoutesData
    
    private func populateRoutesData(routeSegments: RouteSegments) async -> [RouteCardData] {
        var routes: [RouteCardData] = []
        
        for segment in routeSegments {
            guard
                let departureDate: Date = isoDateFormatter.date(from: segment.departure ?? ""),
                let arrivalDate: Date = isoDateFormatter.date(from: segment.arrival ?? "")
            else {
                setError(errorType: .serverError)
                return routes
            }
            
            let hasTransfers = segment.has_transfers ?? false
            var transferTitle: String = ""
            
            if hasTransfers == true, let transfers = segment.transfers {
                transferTitle = transfers
                    .compactMap { $0.title }
                    .joined(separator: ", ")
            }
            
            var carrierId: Int = segment.thread?.carrier?.code ?? 0
            
            if carrierId == 0 {
                segment.details?.forEach { detail in
                    if let thread = detail.value1?.thread, let carrierCode = thread.carrier?.code {
                        carrierId = carrierCode
                    }
                }
            }
            
            var carrier: CarrierData = CarrierData(
                code: carrierId,
                title: segment.thread?.carrier?.title ?? "",
                phone: segment.thread?.carrier?.phone ?? "",
                logo: segment.thread?.carrier?.logo ?? "",
                email: segment.thread?.carrier?.email ?? ""
            )

            if
                carrier.logo.isEmpty,
                carrier.email.isEmpty,
                carrierId != 0
            {
                let carrierInfo: Carrier?
                do {
                    carrierInfo = try await carrierInfoDownloader.downloadCarrierFor(carrierCode: carrierId)
                }
                catch {
                    await MainActor.run { setError(errorType: .noInternetConnection) }
                    return routes
                }

                if let carrierInfo {
                    carrier = CarrierData(
                        code: carrierInfo.carrier?.code ?? carrier.code,
                        title: carrierInfo.carrier?.title ?? carrier.title,
                        phone: carrierInfo.carrier?.phone ?? "",
                        logo: carrierInfo.carrier?.logo ?? "",
                        email: carrierInfo.carrier?.email ?? ""
                    )
                }
            }
                
            routes.append(
                RouteCardData(
                    departureDate: departureDate,
                    arrivalDate: arrivalDate,
                    hasTransfers: hasTransfers,
                    transferTitle: transferTitle,
                    carrier: carrier
                )
            )
        }
        
        return routes
    }
    
    // MARK: - getRouteSegments
    
    private func getRouteSegments(
        fromStationId: String,
        toStationId: String
    ) async throws -> RouteSegments {
        let dates: [String] = generateRouteDates()
        
        return try await withThrowingTaskGroup(
            of: SearchResponse.self,
            returning: RouteSegments.self
        ) { group in
            for date in dates {
                group.addTask {
                    try await self.networkService
                        .searchRoutes(
                            from: fromStationId,
                            to: toStationId,
                            date: date,
                            hasTransfers: true
                        )
                }
            }
            
            var segments: RouteSegments = []
            for try await result in group {
                guard let responseSegments = result.segments else { continue }
                segments.append(contentsOf: responseSegments)
            }
            return segments
        }
    }
    
    // MARK: - generateRouteDates
    
    private func generateRouteDates() -> [String] {
        var dates: [String] = []
        let dateFormatter = DateFormatter()// TODO: need singletone ! ! !
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let currentDate = Date()
        let calendar = Calendar.current
        
        for dayOffset in 0..<AppConstants.routeSearchDepthInDays {
            if let date = calendar.date(byAdding: .day, value: dayOffset, to: currentDate) {
                let dateString = dateFormatter.string(from: date)
                dates.append(dateString)
            }
        }
        
        return dates
    }
    
    // MARK: - setError
    
    private func setError(errorType: NetworkErrorType) {
        isLoading = false
        isError = errorType
    }
}
