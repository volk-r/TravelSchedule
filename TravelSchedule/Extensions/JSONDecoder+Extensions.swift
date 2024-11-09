//
//  JSONDecoder+Extensions.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 09.11.2024.
//

import Foundation

import OpenAPIRuntime
import OpenAPIURLSession

extension JSONDecoder {
    func decode<T: Decodable>(from httpBody: HTTPBody, to type: T.Type, upTo maxBytes: Int = 100 * 1024 * 1024) async throws -> T {
        let data = try await Data(collecting: httpBody, upTo: maxBytes)
        return try self.decode(T.self, from: data)
    }
}
