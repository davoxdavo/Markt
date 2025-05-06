//
//  NetwokrService.swift
//  Markt
//
//  Created by Davit Ghushchyan on 05.05.25.
//
import Foundation

protocol SessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: SessionProtocol {}

protocol NetworkClient {
    func request<T: Decodable>(_ endpoint: Endpoint, as type: T.Type) async throws -> T
}

final class NetworkService: NetworkClient {
    private let baseURL: URL
    private let urlSession: SessionProtocol

    init(baseURL: URL, urlSession: SessionProtocol) {
        self.baseURL = baseURL
        self.urlSession = urlSession
    }

    func request<T: Decodable>(_ endpoint: Endpoint, as type: T.Type) async throws -> T {
        let urlRequest = try makeURLRequest(for: endpoint)
        let (data, response) = try await urlSession.data(for: urlRequest)

        try validateResponse(response)
        return try decode(data, as: T.self)
    }
    
    // MARK: Private

    private func makeURLRequest(for endpoint: Endpoint) throws -> URLRequest {
        guard var components = URLComponents(url: baseURL.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: false) else {
            throw APIError.invalidURL
        }
        components.queryItems = endpoint.queryItems

        guard let url = components.url else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }

    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard (200...399).contains(httpResponse.statusCode) else {
            throw APIError.serverError(httpResponse.statusCode)
        }
    }

    private func decode<T: Decodable>(_ data: Data, as type: T.Type) throws -> T {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decodingFailed(error)
        }
    }
}
