//
//  ProductEndpoint.swift
//  Markt
//
//  Created by Davit Ghushchyan on 05.05.25.
//

import Foundation

struct ProductEndpoint: Endpoint {
    var path: String = "/products"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    
    init(offset: Int, limit: Int) {
        queryItems = [ .init(name: "offset", value: "\(offset)"),
                       .init(name: "limit", value: "\(limit)")]
    }
}
