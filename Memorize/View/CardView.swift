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
        Pie(endAngle: .degrees(240))
            .opacity(Constants.Pie.opacity)
            .overlay(
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.Pie.inset)
                    .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            )
            .padding(Constants.inset)
            .cardify(isFaceUp: card.isFaceUp)

        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
    
    private struct Constants {
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        struct Pie {
            static let opacity:CGFloat = 0.4
            static let inset: CGFloat = 5
        }
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
