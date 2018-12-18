//
//  OccasionResultVC.swift
//  Moobee Boyz
//
//  Created by Sean Bamford on 12/17/18.
//  Copyright © 2018 COMP401. All rights reserved.
//

import UIKit

class OccasionResultCell: UITableViewCell{
    
    @IBOutlet weak var label : UILabel!
    
    var _label : String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = Constants.color_
    }
    
    func updateLabel(){
        label.text! = _label
    }
}

class OccasionResultVC: UITableViewController {
    
    var _title : String!
    
    var titleSource : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = _title
        MoviesByOccasion.WW1_WW2.shuffle()
        MoviesByOccasion.Christmas.shuffle()
        MoviesByOccasion.Classic.shuffle()
        MoviesByOccasion.Halloween.shuffle()
        MoviesByOccasion.NewYear.shuffle()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        switch(titleSource){
        case "MoviesByOccasion.WW1_WW2":
            return min(30, MoviesByOccasion.WW1_WW2.count)
        case "MoviesByOccasion.Christmas":
            return min(30, MoviesByOccasion.Christmas.count)
        case "MoviesByOccasion.Classic":
            return min(30, MoviesByOccasion.Classic.count)
        case "MoviesByOccasion.Halloween":
            return min(30, MoviesByOccasion.Halloween.count)
        case "MoviesByOccasion.NewYear":
            return min(30, MoviesByOccasion.NewYear.count)
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OccasionResultCell
        switch(titleSource){
        case "MoviesByOccasion.WW1_WW2":
            cell._label = MoviesByOccasion.WW1_WW2[indexPath.row]
        case "MoviesByOccasion.Christmas":
            cell._label = MoviesByOccasion.Christmas[indexPath.row]
        case "MoviesByOccasion.Classic":
            cell._label = MoviesByOccasion.Classic[indexPath.row]
        case "MoviesByOccasion.Halloween":
            cell._label = MoviesByOccasion.Halloween[indexPath.row]
        case "MoviesByOccasion.NewYear":
            cell._label = MoviesByOccasion.NewYear[indexPath.row]
        default:
            cell._label = ""
        }
        cell.updateLabel()
        return cell
    }
}
