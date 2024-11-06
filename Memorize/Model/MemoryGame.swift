//
// ---------------------------- //
// Original Project: Memorize
// Created on 2024-11-05 by Tim Mitra
// Mastodon: @timmitra@mastodon.social
// Twitter/X: timmitra@twitter.com
// Web site: https://www.it-guy.com
// ---------------------------- //
// Copyright © 2024 iT Guy Technologies. All rights reserved.


import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    /// private(set) means others can only "get" cards
    private(set) var cards: Array<Card>
    
    /// cardContentFactory is a function that returns CardContent
    /// added pairIndex so now cardContentFactory takes an Int
    /// let content: CardContent = cardContentFactory(pairIndex) can infer CardContent type.
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        // cards = Array<Card>()
        // cards = [Card]()
        cards = [] /// swift infers that this is empty array of Card
        // add numberOfPairsOfCards x 2 cards
        // max at least 2
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex) // create the cardContent
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    mutating func choose(_ card: Card) {
       // print("chose that \(card)")
        /// can't just toggle, card is an argument
        /// Cannot use mutating member on immutable value: 'card' is a 'let' constant
        if let chosenIndex = index(of: card) {
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    private func index(of card: Card) -> Int? {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    }
    
    /// need to mark mutating, since it will copy on write.
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    /// nested struct is really MemorizeGame.Card
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
    }
}
