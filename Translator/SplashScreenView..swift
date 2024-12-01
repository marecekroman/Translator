//
//  SplashScreenView..swift
//  Translator
//
//  Created by Roman Mareček on 25.12.2022.
//

import SwiftUI

struct SplashScreenView: View {
    @StateObject private var themeManager = ThemeManager()
    @State private var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            ContentView()
                .environmentObject(themeManager)
        } else {
            VStack {
                VStack {
                    Image(systemName: "globe")
                        .font(.system(size: 120))
                        .foregroundColor(themeManager.textColor)
                    Text("Translator")
                        .font(Font.custom("Montserrat-Bold", size: 26))
                        .foregroundColor(themeManager.textColor)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 2.00)) {
                        self.size = 2
                        self.opacity = 1.00
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(themeManager.backgroundColor)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}
