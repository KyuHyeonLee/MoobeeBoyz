//
//  SearchResultVC.swift
//  Moobee Boyz
//
//  Created by Sean Bamford on 12/16/18.
//  Copyright © 2018 COMP401. All rights reserved.
//

import UIKit

class SearchResultVC: UIViewController {
    
    var image : UIImage!
    
    var actors : String!
    
    var plot : String!
    
    var score : String!
    
    var genre : String!
    
    var rating : String!
    
    var ratingMC : String!
    
    var releaseDate : String!
    
    var _title : String!
    
    var searchResult : SearchResults!
    
    var query : String!
    
    @IBOutlet weak var _image : UIImageView!
    
    @IBOutlet weak var _actors : UILabel!
    
    @IBOutlet weak var _plot : UILabel!
    
    @IBOutlet weak var _score : UILabel!
    
    @IBOutlet weak var _genre : UILabel!
    
    @IBOutlet weak var _rating : UILabel!
    
    @IBOutlet weak var _ratingMC : UILabel!
    
    @IBOutlet weak var _releaseDate : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        _title = searchResult.name
        if searchResult.imageLoc != "N/A"{
            let url = URL(string: searchResult.imageLoc)
            let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                guard let dataResponse = data, error == nil else { return }
                self.image = UIImage(data: dataResponse)
            }
            task.resume()
        }
        let task = URLSession.shared.dataTask(with: URL(string: query!)!) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {return }
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                if let dictionary = jsonResponse as? [String : Any] {
                    self.releaseDate = dictionary["Released"] as? String
                    self.genre = dictionary["Genre"] as? String
                    self.actors = dictionary["Actors"] as? String
                    self.plot = dictionary["Plot"] as? String
                    self.ratingMC = dictionary["Metascore"] as? String
                    self.rating = dictionary["imdbRating"] as? String
                    self.score = dictionary["Rated"] as? String
                    OperationQueue.main.addOperation{
                        self.doUpdateFields()
                    }
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    func doUpdateFields(){
        _image.image = image
        _actors.text = actors
        _plot.text = plot
        _score.text = score == "N/A" ? "" : score
        _genre.text = genre
        _rating.text = rating == "N/A" ? "" : rating
        _ratingMC.text = ratingMC == "N/A" ? "" : ratingMC
        _releaseDate.text = releaseDate
        self.title = _title
    }
    
    @IBAction func tapAddWatchlist(_ sender: Any){
        WatchListVC.addList.append(AddList(Moviename: self._title, MovieImage: self.searchResult.imageLoc))
    }
}
