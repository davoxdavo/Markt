//
//  ThemeSettingsView.swift
//  Markt
//
//  Created by Davit Ghushchyan on 07.05.25.
//

import SwiftUI
import Foundation

struct ThemeSettingsView: View {
    @EnvironmentObject var context: Context
    @AppStorage("selectedTheme") private var selectedThemeRaw = AppTheme.system.rawValue
    
    var body: some View {
        List {
            ForEach(AppTheme.allCases) { theme in
                Button {
                    selectedThemeRaw = theme.rawValue
                    NotificationCenter.default.post(name: AppTheme.notificationName, object: nil)
                } label: {
                    HStack {
                        Text(theme.displayName)
                        Spacer()
                        if theme.rawValue == selectedThemeRaw {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        }
        .navigationTitle("App Theme")
    }
}
