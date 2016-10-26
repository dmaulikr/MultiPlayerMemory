//
//  Score.swift
//  MultiPlayer Memory
//
//  Created by Magnus Huttu on 2016-10-19.
//  Copyright © 2016 Magnus Huttu. All rights reserved.
//

import Foundation

class Score : NSObject, NSCoding {
    var name : String
    var score : Int
    var board : Difficulty
    
    override init() {
        self.name = ""
        self.score = 0
        self.board = Difficulty.Easy
    }
    
    init(name: String, score: Int, board : Difficulty) {
        self.name = name
        self.score = score
        self.board = board
    }
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.score = aDecoder.decodeInteger(forKey: "score")
        self.board = Difficulty.getDifficulty(diff: aDecoder.decodeObject(forKey: "board") as! String)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(score, forKey: "score")
        aCoder.encode(board.rawValue, forKey: "board")
    }
    
}
