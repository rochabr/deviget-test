//
//  RedditTableViewCell.swift
//  deviget_test
//
//  Created by Fernando Rocha Silva on 3/24/16.
//  Copyright © 2016 Fernando Rocha Silva. All rights reserved.
//

import UIKit

class RedditTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var thumbButton: UIButton!
    @IBOutlet weak var numberOfCommentsLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
