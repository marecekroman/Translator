//
//  ThemeManager.swift
//  Translator
//
//  Created by Roman Mareček on 27.11.2024.
//

import SwiftUI
import UIKit

class ThemeManager: ObservableObject {
    @Published var isSystemTheme: Bool
    @Published var isDarkMode: Bool
    
    init() {
        let savedIsSystemTheme = UserDefaults.standard.bool(forKey: "isSystemTheme")
        let savedIsDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        let systemIsDark = UITraitCollection.current.userInterfaceStyle == .dark
        
        self.isSystemTheme = savedIsSystemTheme
        self.isDarkMode = savedIsSystemTheme ? systemIsDark : savedIsDarkMode
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(systemThemeChanged),
            name: NSNotification.Name("UITraitCollectionDidChange"),
            object: nil
        )
    }
    
    @objc func systemThemeChanged() {
        if isSystemTheme {
            isDarkMode = UITraitCollection.current.userInterfaceStyle == .dark
        }
    }
    
    func updateSystemTheme(_ value: Bool) {
        isSystemTheme = value
        UserDefaults.standard.set(value, forKey: "isSystemTheme")
        if isSystemTheme {
            isDarkMode = UITraitCollection.current.userInterfaceStyle == .dark
        }
    }
    
    func updateDarkMode(_ value: Bool) {
        isDarkMode = value
        UserDefaults.standard.set(value, forKey: "isDarkMode")
    }
    
    var backgroundColor: Color {
        isDarkMode ? .black : .white
    }
    
    var textColor: Color {
        isDarkMode ? .red : .blue
    }
}
