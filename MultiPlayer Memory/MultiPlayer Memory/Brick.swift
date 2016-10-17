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
            self.imageView.isHidden = false
            self.open = true
            self.backgroundColor = color
        }
    }
    
    public func close() {
        self.open = false
        self.backgroundColor = UIColor.black
        self.imageView.isHidden = true
    }
    
    public func isOpen() -> Bool {
        return open
    }
    
    public func isMatch() {
        self.isHighlighted = true
        self.isUserInteractionEnabled = false
    }
}
