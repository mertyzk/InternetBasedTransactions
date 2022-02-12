//
//  ViewController.swift
//  LectureNotesApp
//
//  Created by Macbook Air on 8.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pointTableView: UITableView!

    var pointList = [Notlar]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pointTableView.delegate = self
        pointTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getByAll()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let index = sender as? Int
        
        if segue.identifier == "toPointDetail" {
            
            let goToVC = segue.destination as! PointDetailViewController
            
            goToVC.point = pointList[index!]
            
        }
        
    }
    
    func getByAll(){
        
        let url = URL(string: "http://api.aspx")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil || data == nil{
                print("error")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(NotlarRequest.self, from: data!)
                if let gelennotListesi = result.notlar{
                    self.pointList = gelennotListesi
                }else{
                    self.pointList = [Notlar]()
                }
                
                DispatchQueue.main.async {
                    var sum = 0
                    for n in self.pointList{
                        if let n1 = Int(n.not1!),let n2 = Int(n.not2!){
                            sum = sum + (n1+n2)/2
                        }
                        
                    }
                    if self.pointList.count != 0{
                        self.navigationItem.prompt = "SUM : \(sum / self.pointList.count)"
                    }
                    else{
                        self.navigationItem.prompt = "SUM IS NULL"
                    }
                    self.pointTableView.reloadData()
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
        pointList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "puanHucre", for: indexPath) as! PointCellTableViewCell
        let incomingData = pointList[indexPath.row]
        cell.lecturesLabel.text = incomingData.ders_adi
        cell.vizeLabel.text = "\(incomingData.not1!)"
        cell.finalLabel.text = "\(incomingData.not2!)"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toPointDetail", sender: indexPath.row)
        
    }
    

    
}
