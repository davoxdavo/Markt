//
//  ProductListViewModel.swift
//  Markt
//
//  Created by Davit Ghushchyan on 07.05.25.
//

import Foundation
import Combine

class ProductListViewModel: ObservableObject {
    @Published var products: [Product] = []
    private var service: ProductService?
    
    func setup(context: Context) {
        service = ProductService(networkService: context.networkService, storageService: context.storageService)
    }
    
    func getData() {
        guard let service else { return }
        Task {
            do {
                let data = try await service.getProducts()
                await MainActor.run {
                    products.append(contentsOf: data)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func isFavorite(_ index: Int) -> Bool {
        let item = products[index]
        return service?.isFavorite(item.id) ?? false
    }
    
    func toggleFavorite(_ index: Int) {
        let item = products[index]
        if isFavorite(index) {
            service?.removeFavorite(item.id)
        } else {
            service?.setFavorite(item.id)
        }
        implicitlyReloadData()
    }
    
    func implicitlyReloadData() {
        objectWillChange.send()
    }
}
