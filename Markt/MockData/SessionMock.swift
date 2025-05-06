//
//  SessionMock.swift
//  Markt
//
//  Created by Davit Ghushchyan on 06.05.25.
//

import Foundation

class MockSession: SessionProtocol {
    var mockData: Data?
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        guard let mockData else { throw APIError.genericError}
        let response = URLResponse(url: request.url!, mimeType: "", expectedContentLength: 2, textEncodingName: "")
        return (mockData, response)
    }
}
