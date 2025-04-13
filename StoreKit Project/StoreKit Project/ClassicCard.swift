//
//  ClassicCard.swift
//  StoreKit Project
//
//  Created by Jadon Hill on 4/13/25.
//

// ClassicCard.swift
import Foundation

struct ClassicCard: Codable, Identifiable {
    let id = UUID()
    let question: String

    private enum CodingKeys: String, CodingKey {
        case question
    }
}
