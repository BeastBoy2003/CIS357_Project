//
//  StoreManager.swift
//  StoreKit Project
//
//  Created by Jadon Hill on 4/14/25.
//

/*
import StoreKit
import SwiftUI

class StoreManager: ObservableObject {
    @Published var products: [Product] = []
    @Published var purchasedDecks: Set<String> = []
    
    private let productIds = [
        "com.jacobsanchez.cardgame.personal_deck",
        "com.jacobsanchez.cardgame.funny_deck",
        "com.jacobsanchez.cardgame.dare_deck"
    ]
    
    init() {
        Task {
            await fetchProducts()
            await updatePurchasedDecks()
        }
    }
    
    // Fetch available products
    func fetchProducts() async {
        do {
            let products = try await Product.products(for: productIds)
            await MainActor.run {
                self.products = products
            }
        } catch {
            print("Failed to fetch products: \(error)")
        }
    }
    
    /*
    // Purchase a product
    func purchase(_ product: Product) async throws -> Bool {
        let result = try await product.purchase()
        switch result {
        case .success(let transaction):
            await transaction.finish()
            await updatePurchasedDecks()
            return true
        case .userCancelled:
            return false
        case .pending:
            return false
        @unknown default:
            return false
        }
    }
    */
    
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
                // Handle unverified transactions (e.g., log error, but don’t finish)
                return false
            }
        case .userCancelled:
            return false
        case .pending:
            return false
        @unknown default:
            return false
        }
    }
    
    /*
    // Check purchased products
    func updatePurchasedDecks() async {
        var purchased: Set<String> = []
        for await result in Transaction.currentEntitlements {
            if case .verified(let transaction) = result {
                purchased.insert(transaction.productID)
            }
        }
        await MainActor.run {
            self.purchasedDecks = purchased
        }
    }
    */
    
    func updatePurchasedDecks() async {
        var purchased: Set<String> = []
        for await result in Transaction.currentEntitlements {
            if case .verified(let transaction) = result {
                purchased.insert(transaction.productID)
            }
        }
        let updatedPurchased = purchased // Copy to avoid capture issues
        await MainActor.run {
            self.purchasedDecks = updatedPurchased
        }
    }
    
    // Check if a deck is purchased
    func isDeckPurchased(_ deck: String) -> Bool {
        switch deck {
        case "Personal Deck":
            return purchasedDecks.contains("com.jacobsanchez.cardgame.personal_deck")
        case "Funny Deck":
            return purchasedDecks.contains("com.jacobsanchez.cardgame.funny_deck")
        case "Dare Deck":
            return purchasedDecks.contains("com.jacobsanchez.cardgame.dare_deck")
        default:
            return true // Classic Deck is free
        }
    }
}

*/












/*
import StoreKit
import SwiftUI

class StoreManager: ObservableObject {
    @Published var products: [Product] = []
    @Published var purchasedDecks: Set<String> = []
    
    private let productIds = [
        "edu.gvsu.cis.StoreKit-Project.cardgame.personal_deck",
        "edu.gvsu.cis.StoreKit-Project.cardgame.funny_deck",
        "edu.gvsu.cis.StoreKit-Project.cardgame.dare_deck"
    ]
    
    init() {
        print("DEBUG: StoreManager initialized")
        Task {
            await fetchProducts()
            await updatePurchasedDecks()
        }
    }
    
    // Fetch available products
    func fetchProducts() async {
        print("DEBUG: Starting fetchProducts with IDs: \(productIds)")
        do {
            let products = try await Product.products(for: productIds)
            print("DEBUG: Fetched \(products.count) products: \(products.map { "\($0.id) (\($0.displayPrice))" })")
            let updatedProducts = products
            await MainActor.run {
                self.products = updatedProducts
            }
        } catch {
            print("DEBUG: Failed to fetch products: \(error.localizedDescription)")
        }
    }
    
    // Purchase a product
    func purchase(_ product: Product) async throws -> Bool {
        print("DEBUG: Attempting purchase for product: \(product.id)")
        let result = try await product.purchase()
        print("DEBUG: Purchase result received: \(String(describing: result))")
        switch result {
        case .success(let verificationResult):
            switch verificationResult {
            case .verified(let transaction):
                print("DEBUG: Transaction verified: \(transaction.productID)")
                await transaction.finish()
                await updatePurchasedDecks()
                return true
            case .unverified:
                print("DEBUG: Transaction unverified")
                return false
            }
        case .userCancelled:
            print("DEBUG: Purchase cancelled by user")
            return false
        case .pending:
            print("DEBUG: Purchase pending")
            return false
        @unknown default:
            print("DEBUG: Unknown purchase result")
            return false
        }
    }
    
    // Check purchased products
    func updatePurchasedDecks() async {
        print("DEBUG: Checking purchased decks")
        var purchased: Set<String> = []
        for await result in Transaction.currentEntitlements {
            if case .verified(let transaction) = result {
                print("DEBUG: Verified transaction for product: \(transaction.productID)")
                purchased.insert(transaction.productID)
            }
        }
        let updatedPurchased = purchased
        print("DEBUG: Purchased decks: \(updatedPurchased)")
        await MainActor.run {
            self.purchasedDecks = updatedPurchased
        }
    }
    
    // Check if a deck is purchased
    func isDeckPurchased(_ deck: String) -> Bool {
        print("DEBUG: Checking if \(deck) is purchased")
        let result: Bool
        switch deck {
        case "Personal Deck":
            result = purchasedDecks.contains("edu.gvsu.cis.StoreKit-Project.cardgame.personal_deck")
        case "Funny Deck":
            result = purchasedDecks.contains("edu.gvsu.cis.StoreKit-Project.cardgame.funny_deck")
        case "Dare Deck":
            result = purchasedDecks.contains("edu.gvsu.cis.StoreKit-Project.cardgame.dare_deck")
        default:
            result = true // Classic Deck is free
        }
        print("DEBUG: \(deck) purchased: \(result)")
        return result
    }
}


*/

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
