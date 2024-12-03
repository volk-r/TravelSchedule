//
//  TransferOption.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 29.11.2024.
//

import Foundation

enum TransferOption: FilterOptionProtocol {
    static let title: LocalizedStringResource = "Show options with transfers"
    
    var id : String { UUID().uuidString }
    
    case yes
    case no
}

extension TransferOption {
    var description: LocalizedStringResource {
        switch self {
        case .yes: return "Yes"
        case .no: return "No"
        }
    }
}
