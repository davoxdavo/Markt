//
//  ProductDetailViewModel.swift
//  Markt
//
//  Created by Davit Ghushchyan on 07.05.25.
//

import Foundation
import Combine

class ProductDetailViewModel: ObservableObject {
    private var service: ProductService?
    @Published var isFavorite: Bool = false
    
    func setup(context: Context, id: Int) {
        service = ProductService(networkService: context.networkService, storageService: context.storageService)
        isFavorite = isFavorite(id)
    }
    
    func isFavorite(_ id: Int) -> Bool {
        return service?.isFavorite(id) ?? false
    }
    
    func toggleFavorite(_ id: Int) {
        if isFavorite(id) {
            service?.removeFavorite(id)
            isFavorite = false
        } else {
            service?.setFavorite(id)
            isFavorite = true
        }
    }
}
