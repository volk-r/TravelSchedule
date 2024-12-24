//
//  CarrierInfoDownloader.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 21.12.2024.
//

import Foundation

actor CarrierInfoDownloader {
    private var cache: [Int: Carrier] = [:]
    private var activeDownloads: [Int: Task<Carrier?, Error>] = [:]
    private let networkService = NetworkService()

    func downloadCarrierFor(carrierCode: Int) async throws -> Carrier? {
        if cache.keys.contains(carrierCode), let carrierInfo = cache[carrierCode] {
            return carrierInfo
        }

        if let existingDownload = activeDownloads[carrierCode] {
            return try await existingDownload.value
        }

        let downloadTask = Task<Carrier?, Error> { [weak self] in
            return try await self?.networkService.getCarriers(code: carrierCode)
        }

        activeDownloads[carrierCode] = downloadTask

        let carrierInfo = try await downloadTask.value
        if let carrierInfo = carrierInfo {
            cache[carrierCode] = carrierInfo
        }
        activeDownloads.removeValue(forKey: carrierCode)
        return carrierInfo
    }
}
