//
//  ContentView.swift
//  Translator
//
//  Created by Roman Mareček on 25.12.2022.
//

import SwiftUI

struct ContentView: View {
    var trans = Translation()
    @State private var input: String = ""
    @State private var output: String = ""
    
    var body: some View {
        NavigationView {
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
                    trans.getTranslation()
                    output=trans.greetAgain(person: input)
                    
                }
                .frame(width: 600, height: 60.0)
                .foregroundColor(.black)
                .background(Color.red)
                
                
                ZStack{
                    if(output.isEmpty){
                        Text("Translation")
                            .foregroundColor(.red)
                            
                    } else {
                        Text(output)
                    .frame(width: /*@START_MENU_TOKEN@*/350.0/*@END_MENU_TOKEN@*/, height: 50.0)
                    .accentColor(.red)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.red)
                    }
                }
                
                NavigationLink(destination: TranslateHistory()) {
        
                    Text("Translation History")
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.red)
                }
                .offset(x: -70.0, y: 270.0)
                
                NavigationLink(destination: About()) {
        
                    Text("About")
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.red)
                }
                .offset(x: 120.0, y: 210.0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
