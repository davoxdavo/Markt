//
//  SceneDelegate.swift
//  Markt
//
//  Created by Davit Ghushchyan on 05.05.25.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = createTabBarControllers()
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        self.window = window
    }
    
    private func createTabBarControllers() -> [UIViewController] {
        let context = createContext()
        
        let homeVC = UIHostingController(rootView: ProductListView()
            .environmentObject(context))
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let favoritesVC = UIHostingController(rootView: Color.secondary
            .environmentObject(context))
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), tag: 1)
        
        return [homeVC, favoritesVC]
    }
    
    private func createContext() -> Context {
        let networkService = NetworkService(baseURL: URL(string: "https://api.escuelajs.co/api/v1")!,
                                            urlSession: URLSession.shared)
        let cacheService = TemporaryImageCache()
        let storageService = StorageService()
        let context = Context(networkService: networkService, storageService: storageService, imageCacheService: cacheService)
        return context
    }
    
}

