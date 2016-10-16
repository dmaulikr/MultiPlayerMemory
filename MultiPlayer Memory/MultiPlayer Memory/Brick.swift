//
//  Brick.swift
//  MultiPlayer Memory
//
//  Created by Magnus Huttu on 2016-10-10.
//  Copyright © 2016 Magnus Huttu. All rights reserved.
//

import UIKit

class Brick: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    var color : UIColor?
    var open : Bool = false
    var id : Int = 0
    var brickMatchId : Int = 0
    
    
    public func click() {
        if !self.isOpen() {
            open = true
            backgroundColor = color
        }
    }
    
    public func isOpen() -> Bool {
        return open
    }
    
    public func isMatch() {
        self.backgroundColor = UIColor.white
        self.isUserInteractionEnabled = false
    }
}
