//
//  ProductView.swift
//  Markt
//
//  Created by Davit Ghushchyan on 06.05.25.
//

import SwiftUI

struct ProductView: View {
    var product: Product
    var isFavorite: Bool
    @EnvironmentObject var context: Context
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            RemoteImageView(url: URL(string: product.images.first!)!,
                            cache: context.imageCacheService)
            .frame(width: 90, height: 90)
            .background(Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.headline)
                    .lineLimit(nil)
                
                Text(String(format: "$%.2f", product.price))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            VStack {
                Button {
                    
                } label: {
                    Image(systemName: isFavorite ?  "bookmark.fill" : "bookmark")
                }
                .padding(.bottom, 15)
            
                Image(systemName: "chevron.right")
                    .offset(CGSize(width: 0, height: 4))

            }
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 8)
        .background(Color(.tertiarySystemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    VStack {
        ProductView(product: .mock()[4], isFavorite: true)
            .environmentObject(
                Context.mock)
            .padding()
        ProductView(product: .mock()[1], isFavorite: false)
            .environmentObject(
                Context.mock)
            .padding()
    }
}
