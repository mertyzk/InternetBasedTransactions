//
//  PointAddViewController.swift
//  LectureNotesApp
//
//  Created by Macbook Air on 8.02.2022.
//

import UIKit

class PointAddViewController: UIViewController {

    @IBOutlet weak var lessonNameTextField: UITextField!
    @IBOutlet weak var vizeTextField: UITextField!
    @IBOutlet weak var finalTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    @IBAction func addButtonClick(_ sender: Any) {
        
        if let name = lessonNameTextField.text, let vize = vizeTextField.text, let final = finalTextField.text{
            if let v1 = Int(vize), let f1 = Int(final){
                getAdd(ders_adi: name, not1: v1, not2: f1)
            }
        }
    }
    
    func getAdd(ders_adi:String,not1:Int,not2:Int){
        
        var request = URLRequest(url: URL(string: "http://api.aspx")!)
        request.httpMethod = "POST"
        let postString = "ders_adi=\(ders_adi)&not1=\(not1)&not2=\(not2)"
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil || data == nil{
                print("error")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]{
                    print(json)
                }
                    
                
            } catch  {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
}
