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
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card) {
        
    }
    
    /// need to mark mutating, since it will copy on write.
    mutating func shuffle() {
        cards.shuffle()
       // print(cards)
    }
    
    /// nested struct is really MemorizeGame.Card
    struct Card: Equatable {
        static func == (lhs: Card, rhs: Card) -> Bool {
            return lhs.isFaceUp == rhs.isFaceUp && lhs.isMatched == rhs.isMatched && lhs.content == rhs.content
        }
        
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    }
}
