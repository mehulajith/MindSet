//
//  MyTableViewCell.swift
//  depression app
//
//  Created by Mohamed Maazin Sudheer on 9/15/18.
//  Copyright © 2018 Mehul Ajith. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var emoji: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        emoji.layer.shadowColor = UIColor.black.cgColor
        emoji.layer.shadowRadius = 3.0
        emoji.layer.shadowOpacity = 0.3
        emoji.layer.shadowOffset = CGSize(width: 0, height: 4)
        emoji.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
