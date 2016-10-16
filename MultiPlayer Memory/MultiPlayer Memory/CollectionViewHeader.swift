//
//  CollectionViewHeader.swift
//  MultiPlayer Memory
//
//  Created by Magnus Huttu on 2016-10-10.
//  Copyright © 2016 Magnus Huttu. All rights reserved.
//

import UIKit

class CollectionViewHeader: UICollectionViewCell {
    
    @IBOutlet weak var turnLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if let label = turnLabel {
            label.text = "Turn"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
