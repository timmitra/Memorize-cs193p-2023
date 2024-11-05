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
    
    func choose(_ card: Card) {
        
    }
    
    /// nested struct is really MemorizeGame.Card
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
