//
//  FeedViewController.swift
//  InstaFirebaseApplication
//
//  Created by Macbook Air on 18.02.2022.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var emails = [String]()
    var comments = [String]()
    var likes = [Int]()
    var imagesArray = [String]()
    var documentIdArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getDataByFirestore()
    }
    
}

extension FeedViewController:UITableViewDelegate,UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emails.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellName", for: indexPath) as! FeedCellTableViewCell
        cell.userEmailLabel.text = emails[indexPath.row]
        cell.likeCountLabel.text = String(likes[indexPath.row])
        cell.userCommentLabel.text = comments[indexPath.row]
        cell.userImageView.sd_setImage(with: URL(string: self.imagesArray[indexPath.row]))
        cell.documentIdLabel.text = documentIdArray[indexPath.row]
        return cell
        }

    func getDataByFirestore(){
        let fireStoreDb = Firestore.firestore()
        /*let settings = fireStoreDb.settings
        settings.areAnimationsEnabled = true
        fireStoreDb.settings = settings*/
        
        fireStoreDb.collection("Posts").order(by: "date", descending: true)
            .addSnapshotListener { (snapshot,error) in // ne kadar derine inmek istiyorsak db'de dizin olarak, onları ekledikten sonra .addsnapshotlistener
            if error != nil{
                print("error")
            }else{
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.imagesArray.removeAll(keepingCapacity: false)
                    self.emails.removeAll(keepingCapacity: false)
                    self.comments.removeAll(keepingCapacity: false)
                    self.likes.removeAll(keepingCapacity: false)
                    self.documentIdArray.removeAll(keepingCapacity: false)
  
                    for document in snapshot!.documents{
                        let documentID = document.documentID
                        self.documentIdArray.append(documentID)
    
                        if let postedBy = document.get("postedBy") as? String{
                            self.emails.append(postedBy)
                        }
                        
                        if let postComment = document.get("postComment") as? String{
                            self.comments.append(postComment)
                        }
                        
                        if let likes = document.get("likes") as? Int{
                            self.likes.append(likes)
                        }
                        
                        if let imageUrl = document.get("imageUrl") as? String{
                            self.imagesArray.append(imageUrl)
                        }
                    }
                    self.tableView.reloadData()
                }

            }
        }
    }
    
}
