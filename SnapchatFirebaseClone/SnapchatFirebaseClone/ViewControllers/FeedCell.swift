//
//  FeedCell.swift
//  SnapchatFirebaseClone
//
//  Created by Macbook Air on 19.02.2022.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var feedUserNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
