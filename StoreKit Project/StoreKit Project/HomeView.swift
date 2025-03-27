//
//  HomeView.swift
//  StoreKit Project
//
//  Created by Jacob D. Sanchez-Puentes on 3/27/25.
//

import SwiftUI

struct HomeView: View {
    @State private var currentDeckIndex = 0
    @State private var decks = ["Funny Deck", "Personal Deck", "Spicy Deck", "Classic Deck"]
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.green, .blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            VStack {
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
                    
                    Button(action: {
                        if currentDeckIndex < decks.count - 1 {
                            currentDeckIndex += 1
                        }
                    }) {
                        Image(systemName: "arrow.right.circle.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 50))
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}


