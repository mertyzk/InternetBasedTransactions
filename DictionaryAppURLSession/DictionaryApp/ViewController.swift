//
//  ViewController.swift
//  DictionaryApp
//
//  Created by Macbook Air on 8.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var wordTableView: UITableView!
    
    var wordList = [Kelimeler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        wordTableView.delegate = self
        wordTableView.dataSource = self
        searchBar.delegate = self
        
        getByAll()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? Int
        let goToVC = segue.destination as! DetailViewController
        goToVC.word = wordList[index!]
    }
    
    func getByAll(){
        
        let url = URL(string: "http://apiurl")!
        URLSession.shared.dataTask(with: url){ data,response,error in
            if error != nil || data == nil{
                print("error")
                return
            }
            do {
                let result = try JSONDecoder().decode(DictionaryAnswer.self, from: data!)
                self.wordList = result.kelimeler
                DispatchQueue.main.async {
                    self.wordTableView.reloadData()
                }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getBySearch(searchText:String){
        
        var request = URLRequest(url: URL(string: "http://apiurl")!)
        request.httpMethod = "POST"
        let postString = "ingilizce=\(searchText)"
        
        request.httpBody = postString.data(using: .utf8)
        
        
        
        URLSession.shared.dataTask(with: request){ data,response,error in
            if error != nil || data == nil{
                print("error")
                return
            }
            do {
                let result = try JSONDecoder().decode(DictionaryAnswer.self, from: data!)
                self.wordList = result.kelimeler
                DispatchQueue.main.async {
                    self.wordTableView.reloadData()
                }
            }catch{
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
        return wordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let word = wordList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath) as! WordTableViewCell
        cell.turkishLabel.text = word.turkce
        cell.englishLabel.text = word.ingilizce
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: indexPath.row)
    }

}

extension ViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search result: \(searchText)")
        
        getBySearch(searchText: searchText)

    }
}
