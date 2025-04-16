//
//  StoreManager.swift
//  StoreKit Project
//
//  Created by Jadon Hill on 4/14/25.
//

import StoreKit
import SwiftUI

class StoreManager: ObservableObject {
    @Published var products: [Product] = []
    @Published var purchasedDecks: Set<String> = []
    
    private let productIds = [
        "edu.gvsu.cis.storekitproject.personal_deck",
        "edu.gvsu.cis.storekitproject.funny_deck",
        "edu.gvsu.cis.storekitproject.dare_deck"
    ]
    
    init() {
        Task {
            await fetchProducts()
            await updatePurchasedDecks()
        }
    }
    
    func fetchProducts() async {
        do {
            let products = try await Product.products(for: productIds)
            let updatedProducts = products
            await MainActor.run {
                self.products = updatedProducts
            }
        } catch {
        }
    }
    
    func purchase(_ product: Product) async throws -> Bool {
        let result = try await product.purchase()
        switch result {
        case .success(let verificationResult):
            switch verificationResult {
            case .verified(let transaction):
                await transaction.finish()
                await updatePurchasedDecks()
                return true
            case .unverified:
                return false
            }
        case .userCancelled, .pending:
            return false
        @unknown default:
            return false
        }
    }
    
    func updatePurchasedDecks() async {
        var purchased: Set<String> = []
        for await result in Transaction.currentEntitlements {
            if case .verified(let transaction) = result {
                purchased.insert(transaction.productID)
            }
        }
        let updatedPurchased = purchased
        await MainActor.run {
            self.purchasedDecks = updatedPurchased
        }
    }
    
    func isDeckPurchased(_ deck: String) -> Bool {
        switch deck {
        case "Personal Deck":
            return purchasedDecks.contains("edu.gvsu.cis.storekitproject.personal_deck")
        case "Funny Deck":
            return purchasedDecks.contains("edu.gvsu.cis.storekitproject.funny_deck")
        case "Dare Deck":
            return purchasedDecks.contains("edu.gvsu.cis.storekitproject.dare_deck")
        default:
            return true // Classic Deck is free
        }
    }
}
