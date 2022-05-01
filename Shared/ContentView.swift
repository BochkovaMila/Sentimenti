//
//  ContentView.swift
//  Shared
//
//  Created by Mila B on 30.04.2022.
//

import SwiftUI


struct ContentView: View {
    @State private var userInput: String = ""
    @ObservedObject var identifier = SentimentIdentifier()
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
            Image("nlp_app_background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea([.top, .bottom])
                
            }
            VStack(alignment: .center, spacing: 20) {
                
                Text(self.identifier.prediction == "Pos" ? "☺️" : self.identifier.prediction == "Neg" ? "😠" : self.identifier.prediction == "Neutral" ? "😐": "🙂" )
                    .font(.system(size: 160))
                    .scaleEffect(CGFloat(1 + (self.identifier.confidence - 0.5)))
                    .animation(.spring())

                
                TextField("How do people feel about...", text: $userInput)
                    .scaledToFit()
                    .background(.white)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .onChange(of: userInput) { _ in
                        if userInput.last == " " {
                            self.identifier.predict(userInput)
                        }
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                
                Text("Find out!")
                    .font(.system(size: 36.0))
                    .bold()
                    .italic()
                    .foregroundColor(.orange)
                
                
                
                
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
