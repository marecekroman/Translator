//
//  ContentView.swift
//  Translator
//
//  Created by Roman Mareček on 25.12.2022.
//

import SwiftUI
import UIKit
import AVFoundation

extension View {
   func adaptiveStackNavigationViewStyle() -> some View {
       if UIDevice.current.userInterfaceIdiom == .phone {
           return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
       } else {
           return AnyView(self)
       }
   }
}

struct ContentView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State private var input: String = ""
    @State private var output: String = ""
    @State private var isLoading = false
    @State private var sourceLanguage = "en"
    @State private var targetLanguage = "cs"
    @State private var showShareSheet = false
    @State private var synthesizer = AVSpeechSynthesizer()
    @State private var history = UserDefaults.standard.object(forKey: "savedHistory") as? [String: String] ?? [String: String]()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
   
   let availableLanguages = [
       "en": "English",
       "cs": "Czech",
       "de": "German",
       "es": "Spanish",
       "fr": "French",
       "it": "Italian",
       "pl": "Polish",
       "ru": "Russian"
   ]
   
   var backgroundColor: Color {
       themeManager.backgroundColor
   }
   
   var textColor: Color {
       themeManager.textColor
   }
   
   struct Translation: Codable {
       let translatedText: String
   }
   
   struct Response: Codable {
       let responseData: Translation
   }
   
   private func hideKeyboard() {
       UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
   }
   
   private func clearInput() {
       input = ""
       output = ""
   }
   
   var body: some View {
       NavigationView {
           ScrollView {
               VStack(spacing: horizontalSizeClass == .compact ? 15 : 20) {
                   HStack {
                       LanguagePicker(selection: $sourceLanguage, languages: availableLanguages)
                       
                       Image(systemName: "arrow.right")
                           .foregroundColor(textColor)
                           .padding(.horizontal)
                       
                       LanguagePicker(selection: $targetLanguage, languages: availableLanguages)
                   }
                   .padding(.horizontal, horizontalSizeClass == .compact ? 10 : 20)
                   
                   VStack(alignment: .trailing) {
                       TextEditor(text: $input)
                           .frame(height: horizontalSizeClass == .compact ? 80 : 100)
                           .padding(10)
                           .colorScheme(themeManager.isDarkMode ? .dark : .light)
                           .cornerRadius(10)
                           .overlay(
                               RoundedRectangle(cornerRadius: 10)
                                   .stroke(textColor, lineWidth: 1)
                           )
                           .foregroundColor(themeManager.textColor)
                       
                       Button(action: clearInput) {
                           Image(systemName: "xmark.circle.fill")
                               .foregroundColor(textColor)
                       }
                   }
                   .padding(.horizontal, horizontalSizeClass == .compact ? 10 : 20)
                   
                   Button(action: {
                       hideKeyboard()
                       if(!input.isEmpty) {
                           getTranslation { result in
                               switch result {
                               case .success(let translation):
                                   output = translation.translatedText
                                   history[input] = output
                                   UserDefaults.standard.set(history, forKey: "savedHistory")
                               case .failure(let error):
                                   print(error)
                               }
                           }
                       }
                   }) {
                       HStack {
                           if isLoading {
                               ProgressView()
                                   .progressViewStyle(CircularProgressViewStyle(tint: .white))
                           }
                           Text("Translate")
                               .fontWeight(.semibold)
                       }
                       .frame(width: 120, height: 40)
                       .background(textColor)
                       .foregroundColor(.white)
                       .clipShape(Capsule())
                   }
                   
                   if !output.isEmpty {
                       VStack(spacing: 10) {
                           Text(output)
                               .padding()
                               .frame(maxWidth: .infinity)
                               .background(themeManager.isDarkMode ? Color.black : Color.white)
                               .cornerRadius(10)
                               .foregroundColor(themeManager.textColor)
                               .overlay(
                                   RoundedRectangle(cornerRadius: 10)
                                       .stroke(themeManager.textColor, lineWidth: 1)
                               )
                               .padding(.horizontal, horizontalSizeClass == .compact ? 10 : 20)
                           
                           HStack {
                               Button(action: {
                                   do {
                                       try AVAudioSession.sharedInstance().setCategory(.playAndRecord, options: .duckOthers)
                                       try AVAudioSession.sharedInstance().setActive(true)
                                       
                                       let languageCode = getVoiceLanguageCode(for: targetLanguage)
                                       if let voice = AVSpeechSynthesisVoice(language: languageCode) {
                                           let utterance = AVSpeechUtterance(string: output)
                                           utterance.voice = voice
                                           utterance.rate = 0.4
                                           utterance.volume = 1.0
                                           synthesizer.speak(utterance)
                                       }
                                   } catch {
                                       print("Could not enable audio: \(error.localizedDescription)")
                                   }
                               }) {
                                   Image(systemName: "speaker.wave.2")
                                       .foregroundColor(textColor)
                               }
                               .padding()
                               
                               Button(action: {
                                   UIPasteboard.general.string = output
                               }) {
                                   Image(systemName: "doc.on.doc")
                                       .foregroundColor(textColor)
                               }
                               .padding()
                               
                               Button(action: { showShareSheet = true }) {
                                   Image(systemName: "square.and.arrow.up")
                                       .foregroundColor(textColor)
                               }
                               .padding()
                           }
                       }
                   }
                   
                   Spacer()
                   
                   HStack(spacing: horizontalSizeClass == .compact ? 10 : 20) {
                       NavigationLink(destination: TranslateHistory(history: $history).environmentObject(themeManager)) {
                           Text("History")
                               .padding()
                               .foregroundColor(.white)
                               .background(textColor)
                               .clipShape(Capsule())
                       }
                       
                       NavigationLink(destination: About().environmentObject(themeManager)) {
                           Text("About")
                               .padding()
                               .foregroundColor(.white)
                               .background(textColor)
                               .clipShape(Capsule())
                       }
                   }
                   .padding(.bottom, horizontalSizeClass == .compact ? 10 : 20)
               }
               .frame(maxWidth: .infinity)
               .padding(.vertical, horizontalSizeClass == .compact ? 10 : 20)
           }
           .background(backgroundColor)
           .navigationBarItems(trailing: themeToggle)
           .sheet(isPresented: $showShareSheet) {
               ShareSheet(items: [output])
           }
           .onTapGesture {
               hideKeyboard()
           }
       }
       .navigationViewStyle(StackNavigationViewStyle())
       .adaptiveStackNavigationViewStyle()
   }
   
   private var themeToggle: some View {
       Menu {
           Button(action: {
               themeManager.updateSystemTheme(true)
           }) {
               HStack {
                   Text("System Theme")
                   if themeManager.isSystemTheme {
                       Image(systemName: "checkmark")
                   }
               }
           }
           
           Button(action: {
               themeManager.updateSystemTheme(false)
               themeManager.updateDarkMode(true)
           }) {
               HStack {
                   Text("Dark Mode")
                   if !themeManager.isSystemTheme && themeManager.isDarkMode {
                       Image(systemName: "checkmark")
                   }
               }
           }
           
           Button(action: {
               themeManager.updateSystemTheme(false)
               themeManager.updateDarkMode(false)
           }) {
               HStack {
                   Text("Light Mode")
                   if !themeManager.isSystemTheme && !themeManager.isDarkMode {
                       Image(systemName: "checkmark")
                   }
               }
           }
       } label: {
           Image(systemName: themeManager.isDarkMode ? "moon.fill" : "sun.max.fill")
               .foregroundColor(textColor)
       }
   }
   
   private func getVoiceLanguageCode(for languageCode: String) -> String {
       switch languageCode {
           case "en": return "en-US"
           case "cs": return "cs-CZ"
           case "de": return "de-DE"
           case "es": return "es-ES"
           case "fr": return "fr-FR"
           case "it": return "it-IT"
           case "pl": return "pl-PL"
           case "ru": return "ru-RU"
           default: return "en-US"
       }
   }
   
   func getTranslation(completion: @escaping (Result<Translation, Error>) -> Void) {
       let address = "https://api.mymemory.translated.net/get?q=\(input)&langpair=\(sourceLanguage)|\(targetLanguage)"
       
       guard let urlString = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
             let url = URL(string: urlString) else { return }
       
       let task = URLSession.shared.dataTask(with: url) { data, response, error in
           if let error = error {
               completion(.failure(error))
               return
           }
           
           guard let data = data else {
               completion(.failure(NSError(domain: "com.example.app", code: 0,
                   userInfo: [NSLocalizedDescriptionKey: "Data was not returned from the server."])))
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
}
