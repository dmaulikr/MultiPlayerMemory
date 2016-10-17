//
//  Player.swift
//  MultiPlayer Memory
//
//  Created by Magnus Huttu on 2016-10-17.
//  Copyright © 2016 Magnus Huttu. All rights reserved.
//

import Foundation

class Player {
    var id : Int
    var turn : Bool
    var points : Int
    
    init() {
        id = 1
        turn = false
        points = 0
    }
    init(id : Int, turn : Bool) {
        self.id = id
        self.turn = turn
        self.points = 0
    }
    
    func changeTurn() {
        turn = !turn
    }
    
    func isTurn() -> Bool {
        return turn
    }
    
    func addPoint() {
        points += 1
    }
}
