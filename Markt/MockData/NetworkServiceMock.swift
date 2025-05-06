//
//  NetworkServiceMock.swift
//  Markt
//
//  Created by Davit Ghushchyan on 06.05.25.
//

class NetworkServiceMock {
    func request<T>(_ endpoint: any Endpoint, as type: T.Type) async throws -> T where T : Decodable {
        fatalError()
    }
}
