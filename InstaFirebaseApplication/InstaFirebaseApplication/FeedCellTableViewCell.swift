//
//  FeedCellTableViewCell.swift
//  InstaFirebaseApplication
//
//  Created by Macbook Air on 19.02.2022.
//

import UIKit
import Firebase



class FeedCellTableViewCell: UITableViewCell {

    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userCommentLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var documentIdLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButton(_ sender: Any) {

        let fireStoreDb = Firestore.firestore()
        if let likeCount = Int(likeCountLabel.text!){
            
        let likeStore = ["likes" : likeCount+1] as [String:Any]
        fireStoreDb.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge: true)
            
        }

    }
}
