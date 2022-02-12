//
//  DetailViewController.swift
//  DictionaryApp
//
//  Created by Macbook Air on 8.02.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var englishLabel: UILabel!
    @IBOutlet weak var turkishLabel: UILabel!
    
    var word:Kelimeler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let w = word {
            englishLabel.text = w.ingilizce
            turkishLabel.text = w.turkce
        }
    }
    

}
