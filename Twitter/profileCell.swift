//
//  profileCell.swift
//  Twitter
//
//  Created by Erica Lee on 2/28/16.
//  Copyright © 2016 Erica Lee. All rights reserved.
//

import UIKit

class profileCell: UITableViewCell {

    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
