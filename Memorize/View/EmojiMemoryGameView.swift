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

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    @State var cardCount: Int = 4
    private let aspectRatio: CGFloat = 2/3
    private let mySpacing: CGFloat = 4
    
    var body: some View {
        VStack {
            /// to animate, cards need to be Equatable
            cards
                .animation(.default, value: viewModel.cards)
            /// viewModel.shuffle() is a user intent
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        .padding()
    }
    
    //@ViewBuilder // act as if this was a ViewBuilder
    private var cards: some View {
        
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(mySpacing)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundColor(.orange)
    }
}



#Preview {
    /// add viewModel w/EmojiMemoryGame() for preview
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
