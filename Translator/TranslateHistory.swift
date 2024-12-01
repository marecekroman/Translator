//
//  TranslateHistory.swift
//  Translator
//
//  Created by Roman Mareček on 25.12.2022.
//

import SwiftUI

struct TranslateHistory: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var history: [String: String]
    @Environment(\.presentationMode) var presentationMode
    @State private var showConfirmation = false
    
    var body: some View {
        VStack {
            Text("Translation History")
                .font(.title)
                .foregroundColor(themeManager.textColor)
                .padding()
            
            List {
                ForEach(Array(history.keys), id: \.self) { key in
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Original: \(key)")
                            .fontWeight(.medium)
                            .foregroundColor(themeManager.textColor)
                        Text("Translation: \(history[key] ?? "")")
                            .foregroundColor(themeManager.textColor.opacity(0.7))
                    }
                    .padding(.vertical, 4)
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(PlainListStyle())
            .colorScheme(themeManager.isDarkMode ? .dark : .light)
            
            Button("Clear History") {
                showConfirmation = true
            }
            .foregroundColor(.red)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(themeManager.backgroundColor)
        .alert(isPresented: $showConfirmation) {
            Alert(
                title: Text("Clear History"),
                message: Text("Are you sure you want to clear all translation history?"),
                primaryButton: .destructive(Text("Clear")) {
                    clearHistory()
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    private func deleteItems(at offsets: IndexSet) {
        let keys = Array(history.keys)
        for index in offsets {
            history.removeValue(forKey: keys[index])
        }
        
        if history.isEmpty {
            UserDefaults.standard.removeObject(forKey: "savedHistory")
        } else {
            UserDefaults.standard.set(history, forKey: "savedHistory")
        }
        UserDefaults.standard.synchronize()
    }

    private func clearHistory() {
            history.removeAll()
            UserDefaults.standard.removeObject(forKey: "savedHistory")
            UserDefaults.standard.synchronize()
        }
}
