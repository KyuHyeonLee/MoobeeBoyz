//
//  WatchListVC.swift
//  Moobee Boyz
//
//  Created by COMP401 on 11/24/18.
//  Copyright © 2018 COMP401. All rights reserved.
//

import UIKit

class WatchListCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }



}


class WatchListVC :  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var addList: [AddList] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addList.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WatchListCell", for: indexPath) as! WatchListCell
        return cell
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "WATCH LIST"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }

}

class AddList{
    let Moviename: String
    let MovieImage: String
    
    init(Moviename: String, MovieImage: String){
        self.Moviename = Moviename
        self.MovieImage = MovieImage
    }
}
