//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Isaí on 01/03/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreTotal = 0
    @State private var gameCounter = 0
    
    @State private var countries = ["Estonia","France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack{
            RadialGradient( stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack{
                Spacer()
                
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                
                
                VStack(spacing: 15){
                VStack{
                    Text("Tap the flag of")
                        .foregroundStyle(.secondary)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .font(.largeTitle.weight(.semibold))
                }
                ForEach(0..<3){ number in
                    Button{
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .shadow(radius: 5)
                    }
                }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(scoreTotal)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding( )
            
        }
        .alert(scoreTitle, isPresented: $showingScore){
             Button("Continue", action: askQuestion)
        }message: {
            //Text("Your score is \(scoreTotal)")
        }
        }
    
    func flagTapped(_ number: Int){
        gameCounter += 1
        
        if(gameCounter == 8){
            scoreTitle = "Game over your score is \(scoreTotal)"
            scoreTotal = 0
            gameCounter = 0
        }
        else if number == correctAnswer{
            scoreTitle = "Correct"
            scoreTotal += 1
        }else {
            scoreTitle = "¡Incorrect! the correct flag is: \(countries[correctAnswer])"
        }
        showingScore = true
    }
    
    func askQuestion(){
        countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

