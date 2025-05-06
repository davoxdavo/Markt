//
//  Context.swift
//  Markt
//
//  Created by Davit Ghushchyan on 07.05.25.
//

import Foundation

class Context: ObservableObject {
    var networkService: NetworkClient
    var storageService: StorageInteractor
    var imageCacheService: ImageCache
    
    init(networkService: any NetworkClient,
         storageService: any StorageInteractor,
         imageCacheService: any ImageCache) {
        self.networkService = networkService
        self.storageService = storageService
        self.imageCacheService = imageCacheService
    }
}

extension Context {
    static var mock: Context {
        Context(
            networkService: NetworkService(baseURL: URL(string: "https://api.example.com")!,
                                           urlSession: MockSession()),
            storageService: StorageService(),
            imageCacheService: TemporaryImageCache()
        )
    }
}
