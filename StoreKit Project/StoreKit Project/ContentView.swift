//
//  ContentView.swift
//  StoreKit Project
//
//  Created by Jacob D. Sanchez-Puentes on 3/25/25.
//

import SwiftUI

struct ContentView: View {
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
                    Text("Welcome to the Card Game!")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()

                    NavigationLink(destination: HomeView()) {
                        Text("Click here to play")
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .font(.title2)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

