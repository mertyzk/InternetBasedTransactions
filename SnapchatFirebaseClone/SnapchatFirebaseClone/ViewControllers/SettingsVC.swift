//
//  SettingsVC.swift
//  SnapchatFirebaseClone
//
//  Created by Macbook Air on 19.02.2022.
//

import UIKit
import Firebase

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toSignInVC", sender: nil)
        }catch{
            print(error.localizedDescription)
        }
        
        
    }
    
}
