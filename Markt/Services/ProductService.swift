//
//  ProductWorker.swift
//  Markt
//
//  Created by Davit Ghushchyan on 06.05.25.
//

protocol ProductInteractor {
    var haveMorePage: Bool { get }
    func getProducts() async throws -> [Product]
    func reload() async throws -> [Product]
    func setFavorite(_ productId: Int)
    func isFavorite(_ productId: Int) -> Bool
    func removeFavorite(_ productId: Int)
}

class ProductService: ProductInteractor {
    private var networkService: NetworkClient
    private var storageService: StorageInteractor
    private var limit = 30
    private var offset = 0
    private var isLoading = false
    private(set) var haveMorePage = true
    
    init(networkService: NetworkClient, storageService: StorageInteractor) {
        self.networkService = networkService
        self.storageService = storageService
    }
    
    func reload() async throws -> [Product] {
        offset = 0
        return try await getProducts()
    }
    
    func getProducts() async throws -> [Product] {
        isLoading = true
        let products = try await Task {
            try await networkService.request(ProductEndpoint(offset: offset, limit: limit), as: [Product].self)
        }.value
        
        return await MainActor.run { [weak self, limit] in
            self?.haveMorePage = products.count >= limit
            self?.offset += 1
            self?.isLoading = false
            return products
        }
    }
    
    func isFavorite(_ productId: Int) -> Bool {
        let isFavorite = storageService.get(key: "\(productId)") ?? false
        return isFavorite
    }
    
    func setFavorite(_ productId: Int) {
        storageService.store(model: true, key: "\(productId)")
    }
    
    func removeFavorite(_ productId: Int) {
        storageService.remove(key: "\(productId)")
    }
}
