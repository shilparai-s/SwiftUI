//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Shilpa Seetharam on 16/11/23.
//

import SwiftUI

struct FlagImage: View {
    var name: String
    var body: some View {
        return Image(name)
            .clipShape(Rectangle())
            .cornerRadius(10.0)
            .shadow(radius: 5)
    }
}

struct Title : ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.weight(.bold))
            .foregroundColor(.white)
    }
}

extension View {
    func headerTitle() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var restart = false
    @State private var attempt = 8
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red:0.1,green:0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red:0.76,green:0.65, blue: 0.20), location: 0.3)
        
            ], center: .top, startRadius: 200, endRadius: 700)
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .modifier(Title())
                
                VStack(spacing: 15, content: {
                    VStack {
                        Text("Tap the Flag")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        
                        Text(countries[correctAnswer])
                            .foregroundStyle(.secondary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) {
                        number in
                        Button(action: {
                            flagTapped(number)
                        },label: {
                            FlagImage(name: countries[number])
                        })
                    }

                })
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(Rectangle())
                .cornerRadius(20)
                Text("Score: \(score)")
                    .font(.subheadline.weight(.bold))
                    .foregroundColor(.white)
                Spacer()
            }.padding()
            
        }
        .alert(scoreTitle, isPresented: $showingScore, actions: {
            Button("Continue", action: askQuestion)
        },message: {
            Text("Your Score is \(score)")
        })
        .alert("Restart", isPresented: $restart, actions: {
            Button("Restart",action: restartQuiz)
        },message: {
            Text("Maximum attempt reached. Restart the Quiz")
        })
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score = score + 1
        }else {
            scoreTitle = "Wrong"
        }
        showingScore = true
    }
    
    func askQuestion() {
        
        if attempt == 0 {
            restart = true
        }else {
            attempt = attempt - 1
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    }
    
    func restartQuiz() {
        restart = false
        attempt = 8
        score = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
