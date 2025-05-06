//
//  ImageLoader.swift
//  Markt
//
//  Created by Davit Ghushchyan on 07.05.25.
//

import UIKit
import SwiftUI
import Combine

protocol ImageCache {
    subscript(_ url: URL) -> UIImage? { get set }
}

class TemporaryImageCache: ImageCache {
    private let cache = NSCache<NSURL, UIImage>()

    subscript(_ url: URL) -> UIImage? {
        get { cache.object(forKey: url as NSURL) }
        set {
            if let image = newValue {
                cache.setObject(image, forKey: url as NSURL)
            } else {
                cache.removeObject(forKey: url as NSURL)
            }
        }
    }
}

class ImageLoaderService: ObservableObject {
    @Published var image: UIImage?

    private let url: URL
    private var cache: (any ImageCache)?
    private var cancellable: AnyCancellable?

    init(url: URL, cache: (any ImageCache)? = nil) {
        self.url = url
        self.cache = cache
        load()
    }
    
    func load() {
        if let cached = cache?[url] {
            image = cached
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .handleEvents(receiveOutput: { [weak self] image in
                guard let self = self, let image = image else { return }
                self.cache?[self.url] = image
            })
            .receive(on: DispatchQueue.main)
            .replaceError(with: nil)
            .sink { [weak self] in self?.image = $0 }
    }
    
    deinit {
        cancellable?.cancel()
    }
}
