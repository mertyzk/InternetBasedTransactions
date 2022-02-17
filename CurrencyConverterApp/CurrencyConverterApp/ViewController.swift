//
//  ViewController.swift
//  CurrencyConverterApp
//
//  Created by Macbook Air on 17.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getButton(_ sender: Any) {
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=38f231a019518098faf7a867fbbadf2f")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            do {
                //let result = try JSONDecoder().decode(T##type: Decodable.Protocol##Decodable.Protocol, from: data!)
                let result = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                DispatchQueue.main.async {
                    if let rates = result["rates"] as? [String:Any]{
                        if let cad = rates["CAD"] as? Double{
                            self.cadLabel.text = "CAD: \(cad)"
                        }
                        if let chf = rates["CHF"] as? Double{
                            self.chfLabel.text = "CHF: \(chf)"
                        }
                        if let gbp = rates["GBP"] as? Double{
                            self.gbpLabel.text = "GBP: \(gbp)"
                        }
                        if let jpy = rates["JPY"] as? Double{
                            self.jpyLabel.text = "JPY: \(jpy)"
                        }
                        if let usd = rates["USD"] as? Double{
                            self.usdLabel.text = "USD: \(usd)"
                        }
                        if let tryl = rates["TRY"] as? Double{
                            self.tryLabel.text = "TRY: \(tryl)"
                        }
                        
                    }
                }
                
            } catch  {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}

