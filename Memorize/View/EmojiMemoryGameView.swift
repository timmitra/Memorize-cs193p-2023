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
    typealias Card = EmojiMemoryGame.Card
    @Bindable var gameViewModel: EmojiMemoryGame
    
    @State var cardCount: Int = 4
    private let aspectRatio: CGFloat = 2/3
    private let mySpacing: CGFloat = 4
    
    var body: some View {
        VStack {
            /// to animate, cards need to be Equatable
            cards
                .foregroundColor(gameViewModel.color)
            HStack {
                score
                Spacer()
                /// viewModel.shuffle() is a user intent
                shuffle
            }
            .font(.title)
        }
        .padding()
    }
    
    private var score: some View {
        Text("Score: \(gameViewModel.score)")
            .animation(nil)
    }
    
    private var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                gameViewModel.shuffle()
            }
        }
    }
    
    //@ViewBuilder // act as if this was a ViewBuilder
    private var cards: some View {
        
        AspectVGrid(gameViewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(mySpacing)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .onTapGesture {
                    withAnimation {
                        gameViewModel.choose(card)
                    }
                }
        }
    }
    
    private func scoreChange(causedBy card: Card) -> Int {
        return 0
    }
}



#Preview {
    /// add viewModel w/EmojiMemoryGame() for preview
    EmojiMemoryGameView(gameViewModel: EmojiMemoryGame())
}
