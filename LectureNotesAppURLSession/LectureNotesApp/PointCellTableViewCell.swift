//
//  PointCellTableViewCell.swift
//  LectureNotesApp
//
//  Created by Macbook Air on 8.02.2022.
//

import UIKit

class PointCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lecturesLabel: UILabel!
    @IBOutlet weak var vizeLabel: UILabel!
    @IBOutlet weak var finalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
