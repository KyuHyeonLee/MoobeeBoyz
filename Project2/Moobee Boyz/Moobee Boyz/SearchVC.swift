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
        searchResults.append(SearchResults(searchBar.text!))
        _tableView.reloadData()
    }
    /*
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if(searchText.count < 3) { return }
        searchResults.append(SearchResults(searchText))
        _tableView.reloadData()
    }
    */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(searchResults.count)
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchCell
        print(searchResults[indexPath.row].name)
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
    
    init(_ name: String){
        self.name = name
    }
}
