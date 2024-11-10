//
// ---------------------------- //
// Original Project: Memorize
// Created on 2024-11-09 by Tim Mitra
// Mastodon: @timmitra@mastodon.social
// Twitter/X: timmitra@twitter.com
// Web site: https://www.it-guy.com
// ---------------------------- //
// Copyright © 2024 iT Guy Technologies. All rights reserved.

import SwiftUI

struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    
    let card: Card
    
    /// add an init so we can remove the external name
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(5)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview("CardView") {
    typealias Card = CardView.Card // using the CardView's typealias now
    return VStack {
        HStack {
            CardView(Card(isFaceUp: true, content: "X", id: "test 1"))
                .aspectRatio(4/3, contentMode: .fit)
            CardView(Card(content: "X", id: "test 1"))
        }
        HStack {
            CardView(Card(isFaceUp: true, content: "This is a very long string that will wrap to the next line.", id: "test 1"))
            CardView(Card(isMatched: true, content: "X", id: "test 1"))
        }
    }
        .padding()
        .foregroundColor(.green)
}
