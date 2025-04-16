//
//  Card.swift
//  StoreKit Project
//
//  Created by Jadon Hill on 4/13/25.
//

import Foundation

struct Card: Identifiable, Codable {
    let id: Int
    let question: String
}

struct Deck: Codable {
    let deck: String
    let cards: [Card]
}




func loadDeck(deckName: String) -> [Card] {
    let fileName = deckName.lowercased().replacingOccurrences(of: " ", with: "_")
    guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
        print("Warning: \(fileName).json not found, returning placeholder card for \(deckName)")
        return [Card(id: 1, question: "Placeholder question for \(deckName)")]
    }
    print("Found JSON file at: \(url)")
    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let deck = try decoder.decode(Deck.self, from: data)
        print("Loaded \(deck.cards.count) cards for \(deckName)")
        return deck.cards
    } catch {
        print("Error decoding JSON for \(deckName): \(error)")
        return [Card(id: 1, question: "Placeholder question for \(deckName)")]
    }
}
