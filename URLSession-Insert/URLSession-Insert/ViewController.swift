//
//  ViewController.swift
//  URLSession-Insert
//
//  Created by Macbook Air on 11.02.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //add()
        //delete()
        update()
    }
    
    func add(){
        var request = URLRequest(url: URL(string: "https://localhost:15139/api/colors/add")!) // ReCapProject API
        request.httpMethod = "POST"
        let post = "colorName=SwiftTestColor"
        request.httpBody = post.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { (data,response,error) in
            
            if error != nil || data == nil{
                print("Error")
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
    
    func delete(){
        var request = URLRequest(url: URL(string: "https://localhost:15139/api/colors/delete")!) // ReCapProject API
        request.httpMethod = "POST"
        let post = "kisi_id=3569"
        request.httpBody = post.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { (data,response,error) in
            
            if error != nil || data == nil{
                print("Error")
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
    
    func update(){
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/kisiler/update_kisiler.php")!) // ReCapProject API
        request.httpMethod = "POST"
        let post = "kisi_id=3566&kisi_ad=NEWNAME&kisi_tel=1231231313123"
        request.httpBody = post.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { (data,response,error) in
            
            if error != nil || data == nil{
                print("Error")
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

