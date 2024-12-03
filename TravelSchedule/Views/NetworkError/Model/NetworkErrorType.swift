//
//  NetworkErrorType.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 25.11.2024.
//

import Foundation

enum NetworkErrorType {
    case serverError
    case noInternetConnection
    
    var model: NetworkErrorModel {
        switch self {
        case .serverError:
            NetworkErrorModel(
                imageName: AppImages.serverError,
                description: "Server error"
            )
        case .noInternetConnection:
            NetworkErrorModel(
                imageName: AppImages.noInternetConnection,
                description: "No Internet"
            )
        }
    }
}
