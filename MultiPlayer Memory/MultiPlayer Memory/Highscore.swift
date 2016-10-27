//
//  Highscore.swift
//  MultiPlayer Memory
//
//  Created by Magnus Huttu on 2016-10-19.
//  Copyright © 2016 Magnus Huttu. All rights reserved.
//

import Foundation

class Highscore : NSKeyedArchiver {
    static let sharedInstance : Highscore = {
        let instance = Highscore()
        
        if let obj = (NSKeyedUnarchiver.unarchiveObject(withFile: Highscore.SmallArchiveURL.path) as? [Score]) {
            instance.smallHighscores = obj
        } else {
            instance.smallHighscores = []
        }
        
        if let obj = (NSKeyedUnarchiver.unarchiveObject(withFile: Highscore.LargeArchiveURL.path) as? [Score]) {
            instance.largeHighscores = obj
        } else {
            instance.largeHighscores = []
        }
        
        return instance
    }()
    
    var smallHighscores:[Score] = []
    var largeHighscores:[Score] = []
    
    
    func isHighscore(score: Int, board: Difficulty) -> Bool{
        var highscores : [Score] = []
        if board == Difficulty.Easy {
            highscores = smallHighscores
        } else {
            highscores = largeHighscores
        }
        if highscores.count < 20 {
            return true
        }
        else if (highscores.last?.score)! > score {
            return true
        }
        return false
    }
    
    func addHighscore(name: String, score: Int, board: Difficulty) {
        if board == Difficulty.Easy {
            smallHighscores.append(Score(name: name, score: score, board: board))
            smallHighscores = smallHighscores.sorted(by: {$1.score > $0.score})
        } else {
            largeHighscores.append(Score(name: name, score: score, board: board))
            largeHighscores = smallHighscores.sorted(by: {$1.score > $0.score})
        }
        
        
    }
    
    static var DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let LargeArchiveURL = DocumentsDirectory.appendingPathComponent("largememscores")
    static let SmallArchiveURL = DocumentsDirectory.appendingPathComponent("smallmemscores")
    
    
    func getHighscores(board: Difficulty) -> [Score] {
        if board == Difficulty.Easy {
            return smallHighscores
        }
        return largeHighscores
    }
    
    func saveChanges() {
        
        let isSuccessfulSmallSave = NSKeyedArchiver.archiveRootObject(smallHighscores, toFile: Highscore.SmallArchiveURL.path)
        
        if !isSuccessfulSmallSave {
            print("Failed to save small scores...")
        }
        else {
            print("Saving small scores...")
            print(smallHighscores)
        }
        
        let isSuccessfulLargeSave = NSKeyedArchiver.archiveRootObject(largeHighscores, toFile: Highscore.LargeArchiveURL.path)
        
        if !isSuccessfulLargeSave {
            print("Failed to save large scores...")
        }
        else {
            print("Saving large scores...")
            print(largeHighscores)
        }
        
    }
}
