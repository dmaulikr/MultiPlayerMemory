//
//  Brick.swift
//  MultiPlayer Memory
//
//  Created by Magnus Huttu on 2016-10-10.
//  Copyright © 2016 Magnus Huttu. All rights reserved.
//

import UIKit

class Brick: UICollectionViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    var frontImage : UIImage?
    
    var backgroundImage : UIImage = #imageLiteral(resourceName: "Image")
    var color : UIColor?
    var open : Bool = false
    var id : Int = 0
    var brickMatchId : Int = 0
    
    public func click() {
        if !self.isOpen() {
            self.open = true
            let newImageView = UIImageView(frame: cardView.bounds)
            newImageView.image = frontImage!
            UIView.transition(from: imageView!, to: newImageView, duration: 1, options: .transitionFlipFromRight, completion: nil)
            self.imageView = newImageView
        }
    }
    
    public func close() {
        self.open = false
        let newImageView = UIImageView(frame: cardView.bounds)
        newImageView.image = backgroundImage
        UIView.transition(from: imageView!, to: newImageView, duration: 1, options: .transitionFlipFromLeft, completion: nil)
        self.imageView = newImageView
    }
    
    public func isOpen() -> Bool {
        return open
    }
    
    public func isMatch() {
        self.isUserInteractionEnabled = false
    }
}
