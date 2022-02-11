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
        //update()
        getAll()
        //search()
    }
    
    func add(){
        var request = URLRequest(url: URL(string: "http://localhost:30831/api/colors/add")!) // ReCapProject API
        request.httpMethod = "POST"
        let post = "colorId=18&colorName=SwiftTestColor"
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
        var request = URLRequest(url: URL(string: "http://localhost:30831/api/colors/delete")!) // ReCapProject API
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
        var request = URLRequest(url: URL(string: "http://localhost:30831/api/colors/update")!) // ReCapProject API
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
    
    func getAll(){
        let url = URL(string: "http://localhost:30831/api/colors/getall")! // ReCapProject API
        URLSession.shared.dataTask(with: url){ (data,response,error) in
            if error != nil || data == nil{
                print("error")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(ColorsResult.self, from: data!)
                
                for color in result.colors!{
                    print("Color id: \(color.colorId!)")
                    print("Color name: \(color.colorName!)")
                }
            } catch  {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    func search() {
        var request = URLRequest(url: URL(string: "http://localhost:30831/api/colors/search")!) // ReCapProject API
        request.httpMethod = "POST"
        let post = "kisi_ad=a"
        request.httpBody = post.data(using: .utf8)
        URLSession.shared.dataTask(with: request){ (data,response,error) in
            if error != nil || data == nil{
                print(error?.localizedDescription)
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

