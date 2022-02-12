//
//  KelimelerDao.swift
//  DictionaryApp
//
//  Created by Macbook Air on 12.02.2022.
//

import Foundation

class Kelimelerdao{
    
    var object = [Kelimeler]()
    
    func getByAll(){
        
        let url = URL(string: "http://kasimadalan.pe.hu/sozluk/tum_kelimeler.php")!
        URLSession.shared.dataTask(with: url){ data,response,error in
            if error != nil || data == nil{
                print("error")
                return
            }
            do {
                let result = try JSONDecoder().decode(DictionaryAnswer.self, from: data!)
                self.object = result.kelimeler
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}
