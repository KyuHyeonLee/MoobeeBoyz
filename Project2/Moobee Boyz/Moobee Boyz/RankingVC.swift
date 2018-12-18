//
//  RankingVC.swift
//  Moobee Boyz
//
//  Created by Sean Bamford on 11/14/18.
//  Copyright © 2018 COMP401. All rights reserved.
//

import UIKit

class RankingCell: UITableViewCell{
    
    
    
    var _image_: UIImage?
    var _text_: String?
    @IBOutlet weak var _image: UIImageView?
    @IBOutlet weak var _text: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib();
    }
    
    func updateData(){
        _image!.image = _image_!
        _text!.text = _text_!
    }
}

class RankingVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var populars : [SearchResults] = []
    
    var images : [UIImage] = []
    
    let RankingSectionTitle: [String] = ["Top 5 Movies"]
    
    @IBOutlet weak var _tableView : UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(populars.count, images.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RankingCell
        cell._text_ = populars[indexPath.row].name
        cell._image_ = images[indexPath.row]
        cell.updateData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        _tableView.delegate = self
        _tableView.dataSource = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: Date())
        let url = URL(string:
            "https://api.themoviedb.org/3/discover/movie?primary_release_year=\(year)&sort_by=vote_average.desc&certification_country=us&api_key=b29527a69e60d6e3c0dd359bd8ecd99f&with_original_language=en")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {return }
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                if let dictionary = jsonResponse as? [String : Any] {
                    let results = dictionary["results"] as? [[String : Any]]
                    var i = 0;
                    while i < 5{
                        self.populars.append(SearchResults(name: results![i]["title"] as! String, imageLoc: "https://image.tmdb.org/t/p/w185/\(results![i]["poster_path"] ?? "")"))
                        let _url = URL(string: self.populars[i].imageLoc)
                        let _task = URLSession.shared.dataTask(with: _url!) { (data, response, error) in
                            guard let dataResponse = data, error == nil else { return }
                            self.images.append(UIImage(data: dataResponse)!)
                            OperationQueue.main.addOperation{
                                self._tableView.reloadData()
                            }
                        }
                        _task.resume()
                        i += 1
                    }
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return RankingSectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.03669167683, green: 0.05745565146, blue: 0.1305693388, alpha: 1)
        let label = UILabel()
        label.text = RankingSectionTitle[section]
        label.textColor = UIColor.white
        label.frame = CGRect(x:5, y:5, width:200, height:25)
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "RANKING"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }
}
