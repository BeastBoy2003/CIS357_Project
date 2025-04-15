//
//  CardView.swift
//  StoreKit Project
//
//  Created by Jadon Hill on 4/13/25.
//

import SwiftUI

struct CardView: View {
    let cards: [Card]
    @State private var currentCardIndex = 0
    @Environment(\.dismiss) private var dismiss
    
    init(cards: [Card]) {
        self.cards = cards.shuffled() 
    }
    
    var body: some View {
        ZStack {
            // Color.black.ignoresSafeArea()
            LinearGradient(
                gradient: Gradient(colors: [.green, .blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                // Card Display
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.black)
                        .shadow(color: .white.opacity(0.2), radius: 10)
                        .frame(width: 300, height: 400)
                    
                    Text(cards[currentCardIndex].question)
                        .foregroundColor(.white)
                        // .font(.title2)
                        .font(.system(size: 30, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 60)
                        .padding(.top, -185)
                }
                
                // Navigation Buttons
                HStack {
                    if currentCardIndex > 0 {
                        Button(action: {
                            currentCardIndex -= 1
                        }) {
                            Text("Back")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.gray.opacity(0.5))
                                .clipShape(Capsule())
                        }
                    }
                    
                    Spacer()
                    
                    if currentCardIndex < cards.count - 1 {
                        Button(action: {
                            currentCardIndex += 1
                        }) {
                            Text("Next")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .clipShape(Capsule())
                        }
                    } else {
                        Button(action: {
                            dismiss() // Return to HomeView
                        }) {
                            Text("Done")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .clipShape(Capsule())
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)
            }
        }
    }
}

#Preview {
    CardView(cards: [Card(id: 1, question: "Sample question??")])
}
