//
//  SettingsViewController.swift
//  InstaFirebaseApplication
//
//  Created by Macbook Air on 18.02.2022.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logoutButton(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toLoginPage", sender: nil)
        }catch{
            print(error.localizedDescription)
        }
        
        
    }
    
}
