//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Kai Major on 11/08/2021.
//

import SwiftUI

struct main: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.orange)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

extension View {
    func mainStyle() -> some View {
        self.modifier(main())
    }
}
struct ContentView: View {
    
    let moves = ["rock", "paper", "scissors"]
    
    @State private var appMove = Int.random(in: 0 ..< 3)
    @State private var outcome = Bool.random()
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    var body: some View {
        VStack {
            VStack {
                
                if outcome == true {
                    Text("The computer chose \(moves[appMove]). What move should you play to win the game.")
                        .mainStyle()
                } else {
                    Text("The computer chose \(moves[appMove]). What move should you play to lose the game.")
                        .mainStyle()
                }
            }
            Spacer()
            VStack {
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.moveTapped(number)
                    }) {
                        Text(self.moves[number])
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(20)
                            .background(Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            
                        
                    }
                }
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle),
                  message:Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                  })
        }
    }
    
    func moveTapped(_ number: Int) {
        if number - appMove == 1 {
            if outcome == true {
                scoreTitle = "Correct!"
                score += 1
            } else {
                scoreTitle = "Wrong! You WIN this game"
            }
            
        } else if appMove - number == 1 {
            if outcome == true {
                scoreTitle = "Wrong! You LOSE this game"
            } else {
                scoreTitle = "Correct!"
                score += 1
            }
        } else if appMove - number == 2 {
            if outcome == true {
                scoreTitle = "Correct!"
                score += 1
            } else {
                scoreTitle = "Wrong! You WIN this game"
            }
        } else if number - appMove == 2 {
            if outcome == true {
                scoreTitle = "Wrong! You LOSE this game"
            } else {
                scoreTitle = "Correct!"
                score += 1
            }
        } else {
            scoreTitle = "Wrong! You DRAW this game"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        appMove = Int.random(in: 0 ..< 3)
        outcome = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
