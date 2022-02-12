//
//  PointDetailViewController.swift
//  LectureNotesApp
//
//  Created by Macbook Air on 8.02.2022.
//

import UIKit

class PointDetailViewController: UIViewController {

    @IBOutlet weak var lessonNameTextField: UITextField!
    @IBOutlet weak var vizeTextField: UITextField!
    @IBOutlet weak var finalTextField: UITextField!
    
    var point:Notlar?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let p = point {
            lessonNameTextField.text = p.ders_adi
            vizeTextField.text = String(p.not1!)
            finalTextField.text = String(p.not2!)
        }
    }
    
    @IBAction func updateButton(_ sender: Any) {
        if let p = point, let name = lessonNameTextField.text, let vize = vizeTextField.text, let final = finalTextField.text{
            if let pid = Int(p.not_id!),let v1 = Int(vize), let f1 = Int(final){
                getUpdate(not_id: pid, ders_adi: name, not1: v1, not2: f1)
            }
        }
    }
    @IBAction func deleteButton(_ sender: Any) {
        if let p = point {
            if let pid = Int(p.not_id!){
                getDelete(not_id: pid)
            }
        }
    }
    
    func getUpdate(not_id:Int,ders_adi:String,not1:Int,not2:Int){
        
        var request = URLRequest(url: URL(string: "http://api.aspx")!)
        request.httpMethod = "POST"
        let postString = "not_id=\(not_id)&ders_adi=\(ders_adi)&not1=\(not1)&not2=\(not2)"
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
    
    func getDelete(not_id:Int){
        
        var request = URLRequest(url: URL(string: "http://api.aspx")!)
        request.httpMethod = "POST"
        let postString = "not_id=\(not_id)"
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
