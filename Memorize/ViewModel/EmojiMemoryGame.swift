//
// ---------------------------- //
// Original Project: Memorize
// Created on 2024-11-05 by Tim Mitra
// Mastodon: @timmitra@mastodon.social
// Twitter/X: timmitra@twitter.com
// Web site: https://www.it-guy.com
// ---------------------------- //
// Copyright © 2024 iT Guy Technologies. All rights reserved.


import SwiftUI

class EmojiMemoryGame {
    /// Cannot use instance member 'emojis' within property initializer; property initializers run before 'self' is available.
    /// Make it static so that it's initialized first as a global, it's now "EmojiMemoryGame.emojis", and make it private so not global outside.
    private static let emojis = ["👻", "🎃", "🤖", "👽", "👾", "😈", "💀", "☠️", "😱", "💩", "🍭", "🧙‍♀️"]
    
    /// make this func static so it's also init'd first.
    /// Unexpected non-void return value in void function
    /// add return type MemoryGame<String> - cannot infer return types
    /// "emojis" can be used here in static func without the long name "EmojiMemoryGame.emojis"
    /// private so only we can create a memo ry game
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 4) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    /// don't need "EmojiMemoryGame.createMemoryGame" since it's inside a global func
    private var model = createMemoryGame()
    
    var cards: Array<MemoryGame <String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }

}
