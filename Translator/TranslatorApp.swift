//
//  TranslatorApp.swift
//  Translator
//
//  Created by Roman Mareček on 25.12.2022.
//

import SwiftUI

@main
struct TranslatorApp: App {
    @StateObject private var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(themeManager)
        }
    }
}
