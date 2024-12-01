//
//  About.swift
//  Translator
//
//  Created by Roman Mareček on 25.12.2022.
//

import SwiftUI

struct About: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.openURL) var openURL
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "globe")
                .font(.system(size: 80))
                .foregroundColor(themeManager.textColor)
            
            Text("Translator App")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(themeManager.textColor)
            
            Text("Version 2.0")
                .font(.subheadline)
                .foregroundColor(themeManager.textColor.opacity(0.8))
            
            Text("Created by Roman Mareček")
                .font(.body)
                .foregroundColor(themeManager.textColor)
            
            Text("This application supports multiple languages and provides features like text-to-speech, translation history, and theme switching.")
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(themeManager.textColor)
            
            Button("Visit Website") {
                openURL(URL(string: "https://github.com/marecekroman")!)
            }
            .padding()
            .background(themeManager.textColor)
            .foregroundColor(themeManager.backgroundColor)
            .cornerRadius(10)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(themeManager.backgroundColor)
    }
}
