//
//  ContentView.swift
//  Translator
//
//  Created by Roman Mareček on 25.12.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var input: String = ""
    @State private var output: String = ""
    
    var body: some View {
        VStack {
            ZStack{
                if(input.isEmpty){
                    Text("Enter text to translate")
                        .foregroundColor(.red)
                }
                TextField(
                    "",
                    text: $input
                )
                .frame(width: /*@START_MENU_TOKEN@*/350.0/*@END_MENU_TOKEN@*/, height: 50.0)
                .accentColor(.red)
                .multilineTextAlignment(.center)
                .foregroundStyle(.red)
            }

            Button("Button") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            }
            .frame(width: 600, height: 60.0)
            .foregroundColor(.black)
            .background(Color.red)
            
            
            ZStack{
                if(input.isEmpty){
                    Text("Translation")
                        .foregroundColor(.red)
                }
                TextField(
                    "",
                    text: $input
                )
                .frame(width: /*@START_MENU_TOKEN@*/350.0/*@END_MENU_TOKEN@*/, height: 50.0)
                .accentColor(.red)
                .multilineTextAlignment(.center)
                .foregroundStyle(.red)
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

