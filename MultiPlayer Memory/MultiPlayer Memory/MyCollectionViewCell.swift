//
//  MyCollectionViewCell.swift
//  MultiPlayer Memory
//
//  Created by Magnus Huttu on 2016-10-17.
//  Copyright © 2016 Magnus Huttu. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    var img : UIImage? {
        didSet {
            image.image = img
        }
    }
}
