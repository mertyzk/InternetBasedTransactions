//
//  Kategoriler.swift
//  FilmlerUygulamasi
//
//  Created by Macbook Air on 8.02.2022.
//

import Foundation

class Kategoriler:Codable{
    
    var kategori_id:String?
    var kategori_ad:String?
    
    init() {
        
    }
    
    init(kategori_id:String,kategori_ad:String) {
        self.kategori_id = kategori_id
        self.kategori_ad = kategori_ad
    }
}
