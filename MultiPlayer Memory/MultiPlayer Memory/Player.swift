//
//  Player.swift
//  MultiPlayer Memory
//
//  Created by Magnus Huttu on 2016-10-17.
//  Copyright © 2016 Magnus Huttu. All rights reserved.
//

import Foundation
import UIKit

class Player {
    var id : Int
    var turn : Bool
    var points : Int
    var pView : UIView?
    var pLabel : UILabel?
    var pointLabel : UILabel?
    var pointValLabel : UILabel?
    
    init() {
        id = 1
        turn = false
        points = 0
    }
    
    init(id : Int, turn : Bool, view :UIView, pLabel :UILabel, pointLabel :UILabel, pointValLabel :UILabel) {
        self.id = id
        self.turn = turn
        self.points = 0
        self.pView = view
        self.pLabel = pLabel
        self.pointLabel = pointLabel
        self.pointValLabel = pointValLabel
    }
    
    func changeTurn() {
        turn = !turn
        if turn {
            pView!.backgroundColor = UIColor.orange
        } else {
            pView!.backgroundColor = UIColor.white
        }
    }
    
    func isTurn() -> Bool {
        return turn
    }
    
    func addPoint() {
        points += 1
        pointValLabel!.text = "\(points)"
    }
}
