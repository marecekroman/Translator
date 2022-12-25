//
//  SplashScreenView..swift
//  Translator
//
//  Created by Roman Mareček on 25.12.2022.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    // Customise your SplashScreen here
    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack {
                VStack {
                    Image(systemName: "globe")
                        .font(.system(size: 120))
                        .foregroundColor(.yellow)
                    Text("Translator")
                        .font(Font.custom("Montserrat-Bold", size: 26))
                        .foregroundColor(.red)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 2.00)) {
                        self.size = 2
                        self.opacity = 1.00
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.teal)
            }
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

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

