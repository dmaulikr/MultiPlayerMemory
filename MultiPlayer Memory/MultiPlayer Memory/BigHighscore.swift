//
//  Highscore.swift
//  MultiPlayer Memory
//
//  Created by Magnus Huttu on 2016-10-19.
//  Copyright © 2016 Magnus Huttu. All rights reserved.
//

import Foundation

class BigHighscore : NSKeyedArchiver, HighscoreProtocol {
    
    static let sharedInstance : BigHighscore = {
        let instance = BigHighscore()
        
        if let obj = (NSKeyedUnarchiver.unarchiveObject(withFile: BigHighscore.ArchiveURL.path) as? [Score]) {
            instance.highscores = obj
        } else {
            instance.highscores = []
        }
        
        return instance
    }()
    
    
    var highscores:[Score] = []
    
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
        highscores.append(Score(name: name, score: score, board: Difficulty.Easy))
        highscores = highscores.sorted(by: {$0.score < $1.score})
    }
    
    func getHighscores() -> [Score] {
        return highscores
    }
    
    func removeScore(index: Int) {
        highscores.remove(at: index)
    }
    
    static var DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("bigmemscores")
    
    func saveChanges() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(highscores, toFile: BigHighscore.ArchiveURL.path)
        
        if !isSuccessfulSave {
            print("Failed to save scores...")
        }
        else {
            print("Saving scores...")
        }
        
        
    }
}
