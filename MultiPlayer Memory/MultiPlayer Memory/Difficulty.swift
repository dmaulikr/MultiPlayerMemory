//
//  Difficulty.swift
//  MultiPlayer Memory
//
//  Created by Magnus Huttu on 2016-10-07.
//  Copyright © 2016 Magnus Huttu. All rights reserved.
//


enum Difficulty : String {
    case Easy, Hard
    
    static func getDifficulty(rawVal: String) -> Difficulty {
        if rawVal == "Easy" {
            return Difficulty.Easy
        }
        return Difficulty.Hard
    }
}
