//
//  ContentView.swift
//  WordScambler
//
//  Created by Shilpa Seetharam on 28/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = "Random word"
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    var body: some View {
        NavigationStack {
            List(content: {
                Section(content: {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                       
                })
                
                Section(content: {
                    
                    ForEach($usedWords, id: \.self, content: {
                        word in
                        HStack {
                            Image(systemName: "\(word.wrappedValue.count).circle")
                            Text(word.wrappedValue)
                        }
                    })
                    
                },footer: {
                    Text("Score : \($score.wrappedValue)")
                })
            })
            .navigationTitle(rootWord)
            .toolbar(content: {
                Button("New Word", action: {
                    startGame()
                })
            })

        }
        .padding()
        .onSubmit(addNewWord)
        .onAppear(perform: startGame)
        .alert($errorTitle.wrappedValue, isPresented: $showingError, actions: {
            Button("OK", action: {
                
            })
        }, message: {
            Text($errorMessage.wrappedValue)
        })
        
    }
    
    func addNewWord() {
        let answer = self.newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isStartWord(word: answer) else {
            wordError(title: "It is a Start word", message: "Game is to create new word")
            return
        }
        withAnimation{
            self.usedWords.insert(answer, at: 0)
        }
        score = score + 1
        newWord = ""
        
    }
    
    func startGame() {
        guard let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") else {
            fatalError("Unable to load the start.txt")
        }
        guard let startWords = try? String(contentsOf: fileURL) else {
            fatalError("Unable to read the start words")
        }
        
        let allWords = startWords.components(separatedBy: "\n")
        rootWord = allWords.randomElement() ?? "silkworm"
        newWord = ""
        
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func isStartWord(word: String) -> Bool {
        return !rootWord.elementsEqual(word)
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
