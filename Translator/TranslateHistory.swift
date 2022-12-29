//
//  TranslateHistory.swift
//  Translator
//
//  Created by Roman Mareček on 25.12.2022.
//

import SwiftUI

struct TranslateHistory: View {

    @State public var history = UserDefaults.standard.object(forKey: "savedHistory") as? [String: String] ?? [String: String]()
    
    @State private var profileText = ""
    
    func getHistory(){
        for (key, value) in history {
            profileText = profileText + key + " ---> " + value + "\n"
        }
        return
    }
    
    var body: some View {

        VStack{
            Text("Translation history")
                .foregroundColor(.red)
            if #available(iOS 16.0, *) {
                TextEditor(text: .constant(profileText))
                    .padding(.horizontal)
                    .onAppear {
                        self.getHistory()
                    }
                    .scrollContentBackground(.hidden)
                    .background(.black)
                    .foregroundColor(.red)
            } else {
                Text(profileText)
                     .padding(.horizontal)
                     .background(.black)
                     .foregroundColor(.red)
                
                     .onAppear {
                         self.getHistory()
                     }
                     .lineLimit(nil)
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}

struct TranslateHistory_Previews: PreviewProvider {
    static var previews: some View {
        TranslateHistory()
    }
}
