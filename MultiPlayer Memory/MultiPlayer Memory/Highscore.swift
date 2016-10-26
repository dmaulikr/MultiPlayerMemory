//
//  Highscore.swift
//  MultiPlayer Memory
//
//  Created by Magnus Huttu on 2016-10-19.
//  Copyright © 2016 Magnus Huttu. All rights reserved.
//

import Foundation

class Highscore {
    static let sharedInstance = Highscore()
    
    var highscores:[(name: String, score: Int)]
    
    private init() {
        highscores = [("Magnus", 3), ("Emma", 2), ("Pekka", 12)]
        highscores = highscores.sorted(by: {$1.1 < $0.1})
    }
    
    func isHighscore(score: Int) -> Bool{
        if highscores.count < 20 {
            return true
        }
        else if (highscores.last?.score)! > score {
            return true
        }
        return false
    }
    
    func addHighscore(name: String, score: Int) {
        highscores.append((name, score))
        highscores = highscores.sorted(by: {$0.1 < $1.1})
    }
    
    func getHighscores() -> [(name: String, score: Int)] {
        return highscores
    }
}
