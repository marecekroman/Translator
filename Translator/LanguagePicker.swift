//
//  LanguagePicker.swift
//  Translator
//
//  Created by Roman Mareček on 27.11.2024.
//

import SwiftUI
import UIKit

struct LanguagePicker: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var selection: String
    let languages: [String: String]
    
    var body: some View {
        Picker("Language", selection: $selection) {
            ForEach(Array(languages.keys), id: \.self) { key in
                Text(languages[key] ?? "")
                    .tag(key)
                    .foregroundColor(themeManager.textColor)
            }
        }
        .pickerStyle(MenuPickerStyle())
        .accentColor(themeManager.textColor)
        .foregroundColor(themeManager.textColor)
    }
}
