//
//  SearchVC.swift
//  Moobee Boyz
//
//  Created by Sean Bamford on 11/14/18.
//  Copyright © 2018 COMP401. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell{
    @IBOutlet weak var _text: UILabel!
    
    var _text_: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateText(){
        _text.text = _text_
    }
}

class SearchVC: UIViewController, UITableViewDelegate, UISearchBarDelegate, UITableViewDataSource {
    
   
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var _tableView: UITableView!
    
    var apiKeys: [String] = ["e6d495", "7cc1a35f"]
    
    var searchResults: [SearchResults] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        _tableView.delegate = self
        _tableView.dataSource = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(searchBar.text!.count < 3) {return}
        let key = Int.random(in: 0 ..< apiKeys.count)
        let fixedText = searchBar.text!.replacingOccurrences(of: " ", with: "+")
        let url = URL(string: "https://omdbapi.com/?apikey=\(apiKeys[key])&s=\(fixedText)")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {return }
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                if let dictionary = jsonResponse as? [String : Any] {
                    let results = dictionary["Search"] as? [[String : Any]]
                    for result in results!{
                        self.searchResults.append(SearchResults(name: result["Title"] as! String, imageLoc: result["Poster"] as! String))
                        OperationQueue.main.addOperation {
                            self._tableView.reloadData()
                        }
                    }
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if(searchText.count == 0) {
            searchResults.removeAll()
            _tableView.reloadData()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchCell
        cell._text_ = searchResults[indexPath.row].name
        cell.updateText()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class SearchResults{
    let name: String
    let imageLoc: String
    
    init(name: String, imageLoc: String){
        self.name = name
        self.imageLoc = imageLoc
    }
}
