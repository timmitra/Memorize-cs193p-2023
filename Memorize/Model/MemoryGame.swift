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
    private(set)var score = 0
    
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
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        /// set { } gets "newValue" var automatically
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(_ card: Card) {
       // print("chose that \(card)")
        /// can't just toggle, card is an argument
        /// Cannot use mutating member on immutable value: 'card' is a 'let' constant
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[potentialMatchIndex].content == cards[chosenIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2 + cards[chosenIndex].bonus + cards[potentialMatchIndex].bonus
                    } else {
                        if !cards[chosenIndex].hasBeenSeen {
                            score -= 1
                        }
                        if !cards[potentialMatchIndex].hasBeenSeen {
                            score -= 1
                        }
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
        
    /// need to mark mutating, since it will copy on write.
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    /// nested struct is really MemorizeGame.Card
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
                if oldValue != isFaceUp {
                    hasBeenSeen = true
                }
            }
        }
        var hasBeenSeen = false
        var isMatched = false {
            didSet {
                if isMatched {
                    stopUsingBonusTime()
                }
            }
        }
        let content: CardContent
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
        
        // MARK: - Bonus Time
        
        // call this when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isFaceUp && !isMatched && bonusPercentRemaining > 0, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // call this when the card goes back face down or gets matched
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
        
        // the bonus earned so far (one point for every second of the bonusTimeLimit that was not used)
        // this gets smaller and smaller the longer the card remains face up without being matched
        var bonus: Int {
            Int(bonusTimeLimit * bonusPercentRemaining)
        }
        
        // percentage of the bonus time remaining
        var bonusPercentRemaining: Double {
            bonusTimeLimit > 0 ? max(0, bonusTimeLimit - faceUpTime)/bonusTimeLimit : 0
        }
        
        // how long this card has ever been face up and unmatched during its lifetime
        // basically, pastFaceUpTime + time since lastFaceUpDate
        var faceUpTime: TimeInterval {
            if let lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        // can be zero which would mean "no bonus available" for matching this card quickly
        var bonusTimeLimit: TimeInterval = 6
        
        // the last time this card was turned face up
        var lastFaceUpDate: Date?
        
        // the accumulated time this card was face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0

    }
}

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
