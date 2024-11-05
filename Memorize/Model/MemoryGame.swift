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

struct MemoryGame<CardContent> {
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
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex) // create the cardContent
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card) {
        
    }
    
    /// nested struct is really MemorizeGame.Card
    struct Card {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
    }
}
