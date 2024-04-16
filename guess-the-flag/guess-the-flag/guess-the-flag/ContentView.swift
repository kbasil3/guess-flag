//
//  ContentView.swift
//  guess-the-flag
//
//  Created by Katie on 4/15/24.
//

import SwiftUI

struct ContentView: View {
    @State private var yourScore = 0
    @State private var showingScore = false
    @State private var newGame = false
    @State private var scoreTitle = ""
    @State private var gameOver = "You're final score is"
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var count = 0
   
   
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            yourScore += 1
        } else {
            scoreTitle = "Wrong. That flag is \(countries[correctAnswer])"
        }

        showingScore = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        count += 1
        if count == 7 {
            reset()
        }
    }
    
    func reset(){
        if count == 7{
            
           gameOver = "Your final score is \(yourScore)"
            newGame = true
        }
        yourScore = 0
    }
    
    
    var body: some View {
      
        
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                
               
                    Text("Guess the Flag")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)
                        Spacer()
                
                
               
                VStack(spacing: 15) {
                    
                    
                    VStack {
                        
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.white)
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .foregroundStyle(.secondary)
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                    
                }
                Text("Score: \(yourScore)" )
                    .foregroundStyle(.white)
                    .font(.title.bold())
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.regularMaterial)
        
            
            Spacer()
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Spacer()
                Spacer()
                Text("Your score is \(yourScore)")
                Spacer()
            }
         
            .padding(20)
            
            .alert(gameOver, isPresented: $newGame) {
                Button("Reset Game", action: reset)
            } message: {
                Spacer()
                Spacer()
               
                Spacer()
            }
          
            
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
