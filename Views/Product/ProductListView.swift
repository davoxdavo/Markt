//
//  ProductListView.swift
//  Markt
//
//  Created by Davit Ghushchyan on 07.05.25.
//

import SwiftUI

struct ProductListView: View {
    @State private var path = NavigationPath()
    @EnvironmentObject var context: Context
    @ObservedObject var viewModel =  ProductListViewModel()
    @State var showLoading = true
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible())], spacing: 12) {
                    ForEach(viewModel.products.indices, id: \.self) { index in
                        Button {
                            path.append(viewModel.products[index])
                        } label: {
                            ProductView(product: viewModel.products[index], isFavorite: viewModel.isFavorite(index)) {
                                viewModel.toggleFavorite(index)
                            }
                                .onAppear {
                                    if index == viewModel.products.count - 1 {
                                        showLoading = true
                                        viewModel.getData()
                                    }
                                }
                        }
                    }
                    if showLoading {
                        ProgressView()
                    }
                }
                .padding(.horizontal, 5)
            }
            .navigationDestination(for: Product.self) { item in
                ProductDetailView(product: item)
            }
            .onChange(of: path) { oldValue, newValue in
                viewModel.implicitlyReloadData()
            }
        }
        .onAppear {
            viewModel.setup(context: context)
            viewModel.getData()
        }
        .onChange(of: viewModel.products.count) {
            showLoading = false
        }
    }
}

#Preview {
    ProductListView()
        .environmentObject(Context.mock)
    
}
