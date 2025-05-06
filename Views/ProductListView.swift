//
//  ProductListView.swift
//  Markt
//
//  Created by Davit Ghushchyan on 07.05.25.
//

import SwiftUI

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
    
}


struct ProductListView: View {
    @EnvironmentObject var context: Context
    @ObservedObject var viewModel =  ProductListViewModel()
    @State var showLoading = true
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible())], spacing: 12) {
                ForEach(viewModel.products.indices, id: \.self) { index in
                    ProductView(product: viewModel.products[index], isFavorite: viewModel.isFavorite(index))
                        .onAppear {
                            if index == viewModel.products.count - 1 {
                                showLoading = true
                                viewModel.getData()
                            }
                        }
                }
                if showLoading {
                    ProgressView()
                }
            }
            .padding(.horizontal, 5)
        }.onAppear {
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
