//
//  Letter.swift
//  Hangman
//
//  Created by David Choi on 11/11/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import Foundation

class Letter {
    let hiddenLetter : String
    var revealedLetter : String
    var revealed : Int
    
    init(hiddenLetter: String, revealedLetter: String, revealed: Int) {
        self.hiddenLetter = hiddenLetter
        self.revealedLetter = revealedLetter
        self.revealed = revealed
        
    }
    
    func updateReveal() {
        self.revealed = 1
    }
}
