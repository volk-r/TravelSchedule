//
//  AuthenticationMiddleware.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 10.11.2024.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the SwiftOpenAPIGenerator open source project
//
// Copyright (c) 2023 Apple Inc. and the SwiftOpenAPIGenerator project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of SwiftOpenAPIGenerator project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//
import OpenAPIRuntime
import Foundation
import HTTPTypes

/// A client middleware that injects a value into the `Authorization` header field of the request.
struct AuthenticationMiddleware {

    /// The value for the `Authorization` header field.
    private let value: String

    /// Creates a new middleware.
    /// - Parameter value: The value for the `Authorization` header field.
    init(authorizationHeaderFieldValue value: String) { self.value = value }
}

extension AuthenticationMiddleware: ClientMiddleware {
    func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        var request = request
        // Adds the `Authorization` header field with the provided value.
        request.headerFields[.authorization] = value
        return try await next(request, body, baseURL)
    }
}
