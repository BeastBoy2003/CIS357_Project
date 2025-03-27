//
//  ContentView.swift
//  StoreKit Project
//
//  Created by Jacob D. Sanchez-Puentes on 3/25/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showList = false
    @State private var items = ["Item 1", "Item 2", "Item 2"]
        
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.green, .blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Welcome to our Card Game!")
                    .foregroundColor(.white)
                
                Button(showList ? "Back" : "Click To Play") {
                    showList.toggle()
                }
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(30)
                
                if showList {
                    List(items, id: \.self) { item in Text(item)
                    }
                    .transition(.slide)
                    .animation(.easeInOut, value: showList)
                }
            }

        }
    }
}

#Preview {
    ContentView()
}
