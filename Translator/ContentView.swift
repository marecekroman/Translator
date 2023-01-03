//
//  ContentView.swift
//  Translator
//
//  Created by Roman Mareček on 25.12.2022.
//

import Foundation
import SwiftUI

struct ContentView: View{

    struct Translation: Codable {
      let translatedText: String
    }

    struct Response: Codable {
      let responseData: Translation
    }

    func getTranslation(completion: @escaping (Result<Translation, Error>) -> Void) {
        
        let address = "https://api.mymemory.translated.net/get?q=" + input + "&langpair=en|cs"
        
        let urlString = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let url = URL(string: urlString!)
        else{return}
        
      let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
          completion(.failure(error))
          return
        }

        guard let data = data else {
          completion(.failure(NSError(domain: "com.example.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data was not returned from the server."])))
          return
        }

        do {
          let response = try JSONDecoder().decode(Response.self, from: data)
          completion(.success(response.responseData))
        } catch {
          completion(.failure(error))
        }
      }

      task.resume()
    }
    
    @State public var history = UserDefaults.standard.object(forKey: "savedHistory") as? [String: String] ?? [String: String]()
    
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
                
                Button("Translate") {
                    if(!input.isEmpty){
                        getTranslation { result in
                            switch result {
                            case .success(let translation):
                                output = translation.translatedText
                                
                                history[input]=output
                                UserDefaults.standard.set(history, forKey: "savedHistory")
                            case .failure(let error):
                                print(error)
                            }
                        }
                    }
                }
                .frame(width: 120, height: 60.0)
                .foregroundColor(.black)
                .background(Color.red)
                .clipShape(Capsule())
                
                
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
                        .clipShape(Capsule())
                }
                .offset(x: -70.0, y: 270.0)
                
                NavigationLink(destination: About()) {
        
                    Text("About")
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.red)
                        .clipShape(Capsule())
                }
                .offset(x: 120.0, y: 209.0)
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
