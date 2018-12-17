//
//  SearchTabVC.swift
//  Moobee Boyz
//
//  Created by COMP401 on 11/22/18.
//  Copyright © 2018 COMP401. All rights reserved.
//

import UIKit

class SearchTabCell: UITableViewCell {

    @IBOutlet var _text: UILabel!
    
    var _text_: String!
    
    func updateText(){
        _text.text = _text_
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class SearchTabVC : UIViewController, UITableViewDelegate, UISearchBarDelegate, UITableViewDataSource{

    var searchResults: [SearchResults] = []
    
    var selectedRow : Int!

    @IBOutlet var _tableView: UITableView!

    var apiKeys: [String] = ["e6d495", "7cc1a35f"]
    
    //var searchController = UISearchController()
    //var resultsController = UITableViewController()
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResults.removeAll()
        _tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTabCell
        cell._text_ = searchResults[indexPath.row].name
        cell.updateText()
        return cell
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "SEARCH"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        let SearchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = SearchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController!.searchBar.delegate = self
        _tableView.delegate = self
        _tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedRow = indexPath.row
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SearchResultVC
        let key = Int.random(in: 0 ..< apiKeys.count)
        let fixedText = searchResults[selectedRow].name.replacingOccurrences(of: " ", with: "+")
        destination.query = "https://omdbapi.com/?apikey=\(apiKeys[key])&t=\(fixedText)"
        destination.searchResult = searchResults[selectedRow]
    }
}

class SearchResults{
    let name: String
    let imageLoc: String
    
    init(name: String, imageLoc: String){
        self.name = name
        self.imageLoc = imageLoc
    }
}

