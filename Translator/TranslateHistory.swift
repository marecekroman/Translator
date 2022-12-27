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
            profileText = profileText + key + "--->" + value + "\n"
        }
        return
    }

    var body: some View {

        VStack{
            
           TextEditor(text: .constant(profileText))
                .foregroundColor(.secondary)
                .padding(.horizontal)
                .navigationTitle("Translation history")
                .onAppear {
                    self.getHistory()
                }
        }
    }
}


struct TranslateHistory_Previews: PreviewProvider {
    static var previews: some View {
        TranslateHistory()
    }
}
