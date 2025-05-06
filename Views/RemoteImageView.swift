//
//  RemoteImageView.swift
//  Markt
//
//  Created by Davit Ghushchyan on 07.05.25.
//

import SwiftUI

struct RemoteImageView: View {
    @StateObject private var loader: ImageLoaderService
    private let placeholder: Image

    init(url: URL, cache: ImageCache? = nil, placeholder: Image = Image(systemName: "photo")) {
        _loader = StateObject(wrappedValue: ImageLoaderService(url: url, cache: cache))
        self.placeholder = placeholder
    }

    var body: some View {
        content
            .resizable()
            .aspectRatio(contentMode: .fill)
    }

    private var content: Image {
        if let image = loader.image {
            return Image(uiImage: image)
        } else {
            return placeholder
        }
    }
}
