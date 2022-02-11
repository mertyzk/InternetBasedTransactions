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
        add()
    }
    
    func add(){
        var request = URLRequest(url: URL(string: "https://localhost:15139/api/colors/add")!) // ReCapProject API
        request.httpMethod = "POST"
        //request.addValue("application/json", forHTTPHeaderField: "Content-type")
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


}

