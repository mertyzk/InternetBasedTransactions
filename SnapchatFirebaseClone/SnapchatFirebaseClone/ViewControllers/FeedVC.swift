//
//  FeedVC.swift
//  SnapchatFirebaseClone
//
//  Created by Macbook Air on 19.02.2022.
//

import UIKit
import Firebase
import SDWebImage

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var tableView: UITableView!
    let fireStoreDatabase = Firestore.firestore()
    var snapArray = [Snap]()
    var chosenSnap : Snap?
    var timeLeft : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        getUserInfo()
        getSnaps()
    }
    
    func getUserInfo(){
        
        fireStoreDatabase.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { snapshot, error in
            if error != nil{
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "error")
            }else{
                if snapshot?.isEmpty == false && snapshot != nil{
                    for document in snapshot!.documents {
                        if let username = document.get("username") as? String{
                            UserSingleton.sharedUserInfo.email = Auth.auth().currentUser!.email!
                            UserSingleton.sharedUserInfo.username = username
                        }
                    }
                }
            }
        }
    }
    
    func getSnaps(){
        
        fireStoreDatabase.collection("Snaps").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "error")
            }else{
                if snapshot?.isEmpty == false && snapshot != nil{
                    self.snapArray.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents{
                        
                        let documentId = document.documentID
                        
                        if let username = document.get("snapOwner") as? String{
                            if let imageUrlArray = document.get("imageUrlArray") as? [String]{
                                if let date = document.get("date") as? Timestamp{
                                    
                                    if let diff = Calendar.current.dateComponents([.hour], from: date.dateValue(), to: Date()).hour{
                                        if diff >= 24{
                                            self.fireStoreDatabase.collection("Snaps").document(documentId).delete(){(error) in
                                                
                                            }
                                        }
                                        
                                        self.timeLeft = 24 - diff
                                    }
                                    
                                    
                                    let snap = Snap(username: username, imageUrlAray: imageUrlArray, date: date.dateValue())
                                    self.snapArray.append(snap)
                                }
                            }
                        }
                        
                    }
                    
                    self.tableView.reloadData()
                }
            }
        }
        
        
        
    }
    
    func makeAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert,animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snapArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellName", for: indexPath) as! FeedCell
        cell.feedUserNameLabel.text = snapArray[indexPath.row].username
        cell.feedImageView.sd_setImage(with: URL(string: snapArray[indexPath.row].imageUrlAray[0]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.chosenSnap = self.snapArray[indexPath.row]
        performSegue(withIdentifier: "toSnapVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let goToVc = segue.destination as! SnapVC
        goToVc.selectedSnap = chosenSnap
        goToVc.selectedTime = timeLeft
        
    }


}