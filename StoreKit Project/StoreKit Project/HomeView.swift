//
//  HomeView.swift
//  StoreKit Project
//
//  Created by Jacob D. Sanchez-Puentes on 3/27/25.
//



import SwiftUI
import StoreKit

struct HomeView: View {
    @StateObject private var storeManager = StoreManager()
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
                                
                                currentDeckIndex = (currentDeckIndex - 1 + decks.count) % decks.count
                            }) {
                                Image(systemName: "arrow.left.circle.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 50))
                            }
                            .padding()
                            
                            Spacer()
                        
                        if storeManager.isDeckPurchased(decks[currentDeckIndex]) {
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
                        } else {
                            Button(action: {
                                Task {
                                    if let product = storeManager.products.first(where: {
                                        switch decks[currentDeckIndex] {
                                        case "Personal Deck":
                                            return $0.id == "edu.gvsu.cis.storekitproject.personal_deck"
                                        case "Funny Deck":
                                            return $0.id == "edu.gvsu.cis.storekitproject.funny_deck"
                                        case "Dare Deck":
                                            return $0.id == "edu.gvsu.cis.storekitproject.dare_deck"
                                        default:
                                            return false
                                        }
                                    }) {
                                        _ = try await storeManager.purchase(product)
                                    }
                                }
                            }) {
                                Text("Unlock for \(productPrice(for: decks[currentDeckIndex]))")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                    .background(.black)
                                    .clipShape(Capsule())
                            }
                        }
                        
                        Spacer()
                            
                            Button(action: {
                                
                                currentDeckIndex = (currentDeckIndex + 1) % decks.count
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
    
    func deckEmoji(for deck: String) -> String {
        if storeManager.isDeckPurchased(deck) {
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
        } else {
            return "🔒"
        }
    }
    
    func productPrice(for deck: String) -> String {
        let product = storeManager.products.first { product in
            switch deck {
            case "Personal Deck":
                return product.id == "edu.gvsu.cis.storekitproject.personal_deck"
            case "Funny Deck":
                return product.id == "edu.gvsu.cis.storekitproject.funny_deck"
            case "Dare Deck":
                return product.id == "edu.gvsu.cis.storekitproject.dare_deck"
            default:
                return false
            }
        }
        return product?.displayPrice ?? "$0.99"
    }
}

#Preview {
    HomeView()
}

