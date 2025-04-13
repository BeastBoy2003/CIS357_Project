//
//  HomeView.swift
//  StoreKit Project
//
//  Created by Jacob D. Sanchez-Puentes on 3/27/25.
//

import SwiftUI

struct HomeView: View {
    @State private var currentDeckIndex = 0
    @State private var decks = ["Classic Deck", "Personal Deck", "Funny Deck", "Dare Deck"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.green, .blue]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack {
                    Text(deckEmoji(for: decks[currentDeckIndex]))
                        .font(.system(size: 150))
                        .padding(.bottom, 10)
                    
                    Text(decks[currentDeckIndex])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .padding()
                    
                    HStack {
                        Button(action: {
                            if currentDeckIndex > 0 {
                                currentDeckIndex -= 1
                            }
                        }) {
                            Image(systemName: "arrow.left.circle.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 50))
                        }
                        .padding()
                        
                        Spacer()
                        
                        NavigationLink {
                            CardView(cards: loadDeck(deckName: decks[currentDeckIndex]))
                        } label: {
                            Text("Play")
                                .foregroundColor(.white)
                                .font(.title2)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(.black)
                                .clipShape(Capsule())
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            if currentDeckIndex < decks.count - 1 {
                                currentDeckIndex += 1
                            }
                        }) {
                            Image(systemName: "arrow.right.circle.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 50))
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

func deckEmoji(for deck: String) -> String {
    switch deck {
    case "Classic Deck":
        return "🙂"
    case "Funny Deck":
        return "😂"
    case "Personal Deck":
        return "🫣"
    case "Dare Deck":
        return "😈"
    default:
        return "🃏"
    }
}

#Preview {
    HomeView()
}


