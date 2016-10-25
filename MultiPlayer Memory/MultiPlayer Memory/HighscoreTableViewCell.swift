//
//  HighscoreTableViewCell.swift
//  MultiPlayer Memory
//
//  Created by Magnus Huttu on 2016-10-19.
//  Copyright © 2016 Magnus Huttu. All rights reserved.
//

import UIKit

class HighscoreTableViewCell: UITableViewCell {

    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        positionLabel.text =  ""
        nameLabel.text = ""
        scoreLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
