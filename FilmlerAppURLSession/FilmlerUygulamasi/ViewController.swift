//
//  ViewController.swift
//  FilmlerUygulamasi
//
//  Created by Macbook Air on 8.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var kategoriTableView: UITableView!
    
    var kategoriList = [Kategoriler]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kategoriTableView.delegate = self
        kategoriTableView.dataSource = self
        
        getByAllCategory()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? Int
        let goToVc = segue.destination as! FilmViewController
        goToVc.kategori = kategoriList[index!]
    }
    
    func getByAllCategory(){
        let url = URL(string: "http://apiadress.aspx")!
        URLSession.shared.dataTask(with: url){data,response,error in
            if error != nil || data==nil{
                print("error")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(KategoriAnswer.self, from: data!)
                if let incomingCategoryList = result.kategoriler
                {
                    self.kategoriList = incomingCategoryList
                }
                
                DispatchQueue.main.async {
                    self.kategoriTableView.reloadData()
                }
                
                
            } catch  {
                print(error.localizedDescription)
            }
        }.resume()
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        kategoriList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryCellTableViewCell
        let incomingData = kategoriList[indexPath.row]
        cell.categoryNameLabel.text = incomingData.kategori_ad
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let incomingData = kategoriList[indexPath.row]
        print("\(incomingData.kategori_ad!) seçildi")
        self.performSegue(withIdentifier: "toFilm", sender: indexPath.row)
    }
    
    
    
    
    
}
