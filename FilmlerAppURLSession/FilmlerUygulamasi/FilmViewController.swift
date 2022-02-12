//
//  FilmViewController.swift
//  FilmlerUygulamasi
//
//  Created by Macbook Air on 8.02.2022.
//

import UIKit

class FilmViewController: UIViewController {

    @IBOutlet weak var filmCollectionView: UICollectionView!
    
    var filmlist = [Filmler]()
    var kategori:Kategoriler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filmCollectionView.delegate = self
        filmCollectionView.dataSource = self
        
        let design:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = self.filmCollectionView.frame.size.width
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let cellWidth = (width-30)/2
        design.itemSize = CGSize(width: cellWidth, height: cellWidth*1.652)
        design.minimumInteritemSpacing = 10 // yatayda aralarındaki boşluk
        design.minimumLineSpacing = 10 // alt alta arasındaki boşluk
        
        filmCollectionView.collectionViewLayout = design
        
        if let k = kategori{
            navigationItem.title = k.kategori_ad
            
            if let cid = Int(k.kategori_id!){
                getFilmsByCategoryId(kategori_id: cid)
            }
            
            
        }
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? Int
        let goToVc = segue.destination as! FilmDetayViewController
        goToVc.film = filmlist[index!]
    }
    
    func getFilmsByCategoryId(kategori_id:Int){
        var request = URLRequest(url: URL(string: "http://apiadress.aspx")!)
        request.httpMethod = "POST"
        let postString = "kategori_id=\(kategori_id)"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request){data,response,error in
            if error != nil || data==nil{
                print("error")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(FilmAnswer.self, from: data!)
                if let incomingFilmList = result.filmler
                {
                    self.filmlist = incomingFilmList
                }
                
                DispatchQueue.main.async {
                    self.filmCollectionView.reloadData()
                }
                
                
            } catch  {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

extension FilmViewController:UICollectionViewDelegate,UICollectionViewDataSource,FilmHucreCollectionViewCellProtocol{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "filmHucre", for: indexPath) as! FilmHucreCollectionViewCell
        let incomingData = filmlist[indexPath.item]
        item.filmAdiLabel.text = incomingData.film_ad
        item.filmFiyatLabel.text = "14.99"
        
        if let url = URL(string: "http://apiadress.aspx/\(incomingData.film_resim!)"){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    item.filmResimImageView.image = UIImage(data: data!)
                }
            }
        }
        
        
        
        item.filmResimImageView.image = UIImage(named: incomingData.film_resim!)
        item.layer.borderColor = UIColor.lightGray.cgColor
        item.layer.borderWidth = 1.5
        
        item.cellProtocol = self
        item.indexPath = indexPath
        
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: indexPath.item)
    }
    
    func sepeteEkle(indexPath: IndexPath) {
        print("Sepete eklenen: \(filmlist[indexPath.item].film_ad!)")
    }
    
    
}
