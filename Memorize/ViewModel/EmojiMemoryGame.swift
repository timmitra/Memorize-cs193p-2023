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

func createCardContent(forPairAtIndex index: Int) -> String {
    return ["👻", "🎃", "🤖", "👽", "👾", "😈", "💀", "☠️", "😱", "💩", "🍭", "🧙‍♀️"][index]
}

class EmojiMemoryGame {
    private var model = MemoryGame(numberOfPairsOfCards: 4, cardContentFactory: createCardContent)
    
    var cards: Array<MemoryGame <String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }

}
