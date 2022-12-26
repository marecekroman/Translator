//
//  TranslationService.swift
//  Translator
//
//  Created by Roman Mareček on 25.12.2022.
//

import Foundation
import UIKit

class Translation{
    
    func getTranslation(){
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForResource = 300
        let session = URLSession(configuration: config)
        
            //let url = URL(string: "https://api.mymemory.translated.net/get?q=" + input + "&langpair=" + _langPair)!
        let url = URL(string: "https://api.mymemory.translated.net/get?q=ahoj&langpair=en|cs")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
            
        let task = URLSession.shared.dataTask(with: request) { data,
            response,
            error in

            guard let data = data, error == nil else {
                print("error")
                return
            }

            if let httpStatus = response as? HTTPURLResponse {
                //parse(json: data)
                print("status code = \(httpStatus.statusCode)")
            }
        }
        task.resume()
    }
    
    func greetAgain(person: String) -> String {
        return "Hello again, " + person + "!"
    }
    }

