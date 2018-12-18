//
//  WatchListVC.swift
//  Moobee Boyz
//
//  Created by COMP401 on 11/24/18.
//  Copyright © 2018 COMP401. All rights reserved.
//

import UIKit

protocol RefreshTableDelegate{
    func refresh()
}

class WatchListCell: UITableViewCell {

    var delegate : RefreshTableDelegate?
    
    var cellMovie : [String] = []
    
    @IBOutlet weak var moveTitle: UILabel!
    
    @IBOutlet weak var moviePoster: UIImageView!
    
    @IBAction func tapWatched(_ sender: Any) {
        WatchListTVC.addList = WatchListTVC.addList.filter({$0 != cellMovie})
        WatchListTVC.seenList.append(cellMovie)
        delegate?.refresh()
    }
    
    @IBAction func tapPost(_ sender: Any) {
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

class WatchListTVC :  UITableViewController, RefreshTableDelegate {
    func refresh() {
        self.tableView.reloadData()
        print("refresh")
    }
    
    static var addList: [[String]] = []
    
    static var seenList : [[String]] = []
    
    let sectionTitles: [String] = ["Not Yet Watched", "Already Watched"]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return WatchListTVC.addList.count
        } else {
            return WatchListTVC.seenList.count
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func loadImage(image : UIImageView, url : String) {
        let url = URL(string: url)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                image.contentMode = .scaleAspectFit
                image.image = UIImage(data: data!)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WatchListCell", for: indexPath) as! WatchListCell
        if(indexPath.section == 0) {
            cell.moveTitle.text = WatchListTVC.addList[indexPath.row][0]
            loadImage(image: cell.moviePoster, url: WatchListTVC.addList[indexPath.row][1])
            cell.cellMovie = WatchListTVC.addList[indexPath.row]
        } else {
            cell.moveTitle.text = WatchListTVC.seenList[indexPath.row][0]
            loadImage(image: cell.moviePoster, url: WatchListTVC.seenList[indexPath.row][1])
            cell.cellMovie = WatchListTVC.seenList[indexPath.row]
        }
        cell.delegate = self
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "WATCH LIST"
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.03669167683, green: 0.05745565146, blue: 0.1305693388, alpha: 1)
        
        let label = UILabel()
        label.text = sectionTitles[section]
        label.textColor = UIColor.white
        label.frame = CGRect(x:5, y:5, width:200, height:20)
        view.addSubview(label)
        return view
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
}
