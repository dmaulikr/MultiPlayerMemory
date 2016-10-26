//
//  HighscoreProtocol.swift
//  MultiPlayer Memory
//
//  Created by Magnus Huttu on 2016-10-23.
//  Copyright © 2016 Magnus Huttu. All rights reserved.
//

import Foundation

protocol HighscoreProtocol {
    
    func isHighscore(score: Int) -> Bool
    func addHighscore(name: String, score: Int)
    func getHighscores() -> [Score]
    func removeScore(index: Int)
    func saveChanges()

}
