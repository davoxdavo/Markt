//
//  ProductServiceMock.swift
//  Markt
//
//  Created by Davit Ghushchyan on 06.05.25.
//

import Foundation

class ProductServiceMock: ProductInteractor {
    var haveMorePage: Bool
    var products: [Product] = []
    let networkService: NetworkService
    
    init() {
        haveMorePage = true
        let mockSession = MockSession()
        mockSession.mockData = Bundle.readLocalJSONFile(forName: "ProductsMock")
        self.networkService = NetworkService(baseURL: URL(string: "https://api.escuelajs.co/api/v1/")!, urlSession: MockSession())
        
        Task {
            products = try! await getProducts()
        }
        
    }
    
    func getProducts() async throws -> [Product] {
        products = try! await networkService.request(ProductEndpoint(offset: 0, limit: 15), as: [Product].self)
        return products
    }
    
    func reload() async throws -> [Product] {
        return try await getProducts()
    }
    
    func setFavorite(_ productId: Int) {
        
    }
    
    func isFavorite(_ productId: Int) -> Bool {
        return true
    }
    
    func removeFavorite(_ productId: Int) {
        
    }
    

    
}
