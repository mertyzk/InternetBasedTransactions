//
//  FilmHucreCollectionViewCell.swift
//  FilmlerUygulamasi
//
//  Created by Macbook Air on 8.02.2022.
//

import UIKit

protocol FilmHucreCollectionViewCellProtocol{
    func sepeteEkle(indexPath:IndexPath)
}

class FilmHucreCollectionViewCell: UICollectionViewCell {
    
    var cellProtocol:FilmHucreCollectionViewCellProtocol?
    var indexPath:IndexPath?
    
    @IBOutlet weak var filmResimImageView: UIImageView!
    @IBOutlet weak var filmAdiLabel: UILabel!
    @IBOutlet weak var filmFiyatLabel: UILabel!
    @IBAction func sepeteEkleButton(_ sender: Any) {
        cellProtocol?.sepeteEkle(indexPath: indexPath!)
    }
    
}
