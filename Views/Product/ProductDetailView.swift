//
//  ProductDetailView.swift
//  Markt
//
//  Created by Davit Ghushchyan on 07.05.25.
//
import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var context: Context
    let product: Product
    @ObservedObject var viewModel = ProductDetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                ZStack(alignment: .topTrailing) {
                    TabView {
                        ForEach(product.images, id: \.self) { imageUrlString in
                            if let url = URL(string: imageUrlString) {
                                RemoteImageView(url: url,
                                                cache: context.imageCacheService)
                            }
                        }
                    }.frame(height: 300)
                        .tabViewStyle(PageTabViewStyle())
                        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                        .cornerRadius(8)
                    
                    Button {
                        viewModel.toggleFavorite(product.id)
                    } label: {
                        Image(systemName: viewModel.isFavorite ?  "bookmark.fill" : "bookmark")
                    }
                    .padding(.trailing, 15)
                }
                
                Text(product.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(String(format: "$%.2f", product.price))
                    .font(.headline)
                    .foregroundColor(.green)
                
                Text(product.description)
                    .font(.body)
                
                Divider()
                
                HStack {
                    if let categoryUrl = URL(string: product.category.image) {
                        
                        RemoteImageView(url: categoryUrl,
                                        cache: context.imageCacheService)
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .cornerRadius(8)
                    }
                    
                    Text(product.category.name)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding()
        }
        .onAppear {
           viewModel.setup(context: context, id: product.id)
        }
        .navigationTitle("Product Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ProductDetailView(product: .mock().first!)
        .environmentObject(Context.mock)
}
