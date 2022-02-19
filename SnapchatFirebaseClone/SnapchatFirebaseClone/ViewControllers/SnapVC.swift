//
//  SnapVC.swift
//  SnapchatFirebaseClone
//
//  Created by Macbook Air on 19.02.2022.
//

import UIKit

class SnapVC: UIViewController {

    @IBOutlet weak var timeLeftLabel: UILabel!
    
    var selectedSnap : Snap?
    var selectedTime : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let time = selectedTime {
            timeLeftLabel.text = "Time left: \(time)"
        }
        
    }
    


}
