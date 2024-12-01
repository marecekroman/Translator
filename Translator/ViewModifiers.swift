//
//  Untitled.swift
//  Translator
//
//  Created by Roman Mareček on 27.11.2024.
//

import SwiftUI

extension View {
    func setupNavigationBar() -> some View {
        self.modifier(NavigationBarModifier())
    }
}

struct NavigationBarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationViewStyle(StackNavigationViewStyle())
            .if(UIDevice.current.userInterfaceIdiom == .phone) { view in
                view.statusBar(hidden: true)
            }
    }
}

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
