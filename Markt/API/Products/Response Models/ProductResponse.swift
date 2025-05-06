//
//  Product.swift
//  Markt
//
//  Created by Davit Ghushchyan on 05.05.25.
//

import Foundation

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category
    let images: [String]
    let creationAt, updatedAt: String
}

struct Category: Codable, Identifiable {
    let id: Int
    let name: String
    let image: String
}

#if DEBUG

extension Product {
    
    static func mock() -> [Product] {
        guard let data = Bundle.readLocalJSONFile(forName: "ProductsMock") else { fatalError("Couldn't read mock json for products")}
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try! decoder.decode([Product].self, from: data)
    }
}

#endif
