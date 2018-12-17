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
        print(MoviesByOccasion.WW1_WW2.count)
        print(MoviesByOccasion.Christmas.count)
        print(MoviesByOccasion.Halloween.count)
        print(MoviesByOccasion.NewYear.count)
        print(MoviesByOccasion.Classic.count)
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
            let rand = Int.random(in: 0..<MoviesByOccasion.WW1_WW2.count)
            cell._label = MoviesByOccasion.WW1_WW2[rand]
        case "MoviesByOccasion.Christmas":
            let rand = Int.random(in: 0..<MoviesByOccasion.Christmas.count)
            cell._label = MoviesByOccasion.Christmas[rand]
        case "MoviesByOccasion.Classic":
            let rand = Int.random(in: 0..<MoviesByOccasion.Classic.count)
            cell._label = MoviesByOccasion.Classic[rand]
        case "MoviesByOccasion.Halloween":
            let rand = Int.random(in: 0..<MoviesByOccasion.Halloween.count)
            cell._label = MoviesByOccasion.Halloween[rand]
        case "MoviesByOccasion.NewYear":
            let rand = Int.random(in: 0..<MoviesByOccasion.NewYear.count)
            cell._label = MoviesByOccasion.NewYear[rand]
        default:
            cell._label = ""
        }
        cell.updateLabel()
        return cell
    }
}
