//
//  AppTheme.swift
//  Markt
//
//  Created by Davit Ghushchyan on 07.05.25.
//

import UIKit

enum AppTheme: String, CaseIterable, Identifiable {
    static let notificationName = NSNotification.Name(rawValue: "AppThemeDidChange")
    case system
    case light
    case dark

    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .system:
            return "🖥️ System default"
        case .light:
            return "🌞 Light mode"
        case .dark:
            return "🌚 Dark mode"
        }
    }
    
    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .system: return .unspecified
        case .light: return .light
        case .dark: return .dark
        }
    }
}
