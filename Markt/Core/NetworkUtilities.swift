//
//  NetworkUtilities.swift
//  Markt
//
//  Created by Davit Ghushchyan on 05.05.25.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

extension Endpoint {
    var queryItems: [URLQueryItem]? { nil }
    var body: Data? { nil }
}

enum APIError: Error, LocalizedError {
    case invalidURL
    case decodingFailed(Error)
    case serverError(Int)
    case genericError
    case invalidResponse
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Wrong URL"
        case .decodingFailed(let error): return "Decoding failed: \(error.localizedDescription)"
        case .serverError(let code): return "Server returned error code: \(code)"
        case .genericError: return "Something went wrong"
        case .invalidResponse: return "Wrong Response"
        }
    }
}
