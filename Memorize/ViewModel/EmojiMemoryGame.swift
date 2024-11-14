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

@Observable
class EmojiMemoryGame {
    typealias Card = MemoryGame<String>.Card
    /// Cannot use instance member 'emojis' within property initializer; property initializers run before 'self' is available.
    /// Make it static so that it's initialized first as a global, it's now "EmojiMemoryGame.emojis", and make it private so not global outside.
    /// ObservableObject has hidden var objectWillChange, use it by adding @Published and @ObservedObject
    private static let emojis = ["👻", "🎃", "🤖", "👽", "👾", "😈", "💀", "☠️", "😱", "💩", "🍭", "🧙‍♀️"]
    
    /// make this func static so it's also init'd first.
    /// Unexpected non-void return value in void function
    /// add return type MemoryGame<String> - cannot infer return types
    /// "emojis" can be used here in static func without the long name "EmojiMemoryGame.emojis"
    /// private so only we can create a memo ry game
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 8) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    /// don't need "EmojiMemoryGame.createMemoryGame" since it's inside a global func
    private var gameModel = createMemoryGame()
    
    var cards: Array<Card> {
        gameModel.cards
    }
    
    var color: Color {
        .orange
    }
    
    var score: Int {
        gameModel.score
    }
    
    // MARK: - Intents
    
    func shuffle() {
        gameModel.shuffle()
    }
    
    func choose(_ card: Card) {
        gameModel.choose(card)
    }

}
