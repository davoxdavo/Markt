//
//  SceneDelegate.swift
//  Markt
//
//  Created by Davit Ghushchyan on 05.05.25.
//

import UIKit
import SwiftUI
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    @AppStorage("selectedTheme") private var selectedThemeRaw = AppTheme.system.rawValue
    private var cancelable: Set<AnyCancellable> = []
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = createTabBarControllers()
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        monitorThemeChanges()
        self.window = window
        setupTheme()
    }
    
    private func monitorThemeChanges() {
        NotificationCenter.default.addObserver(forName: AppTheme.notificationName, object: nil, queue: .main) { [weak self] _ in
            self?.setupTheme()
        }
    }
    
    private func setupTheme() {
        guard let theme = AppTheme(rawValue: self.selectedThemeRaw)?.userInterfaceStyle else { return }
        window?.overrideUserInterfaceStyle = theme
    }
    
    private func createTabBarControllers() -> [UIViewController] {
        let context = createContext()
        
        let homeVC = UIHostingController(rootView: ProductListView()
            .environmentObject(context)
        )
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let favoritesVC = UIHostingController(rootView: ThemeSettingsView()
            .environmentObject(context)
        )
        favoritesVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)
        
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

