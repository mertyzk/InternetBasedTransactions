//
//  WordTableViewCell.swift
//  DictionaryApp
//
//  Created by Macbook Air on 8.02.2022.
//

import UIKit

class WordTableViewCell: UITableViewCell {

    @IBOutlet weak var englishLabel: UILabel!
    
    @IBOutlet weak var turkishLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
