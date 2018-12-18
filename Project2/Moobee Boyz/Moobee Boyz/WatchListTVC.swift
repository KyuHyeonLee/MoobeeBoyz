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
        self.tableView.allowsMultipleSelectionDuringEditing = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let finalDestUrl : URL = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]).appendingPathComponent("watchlist.txt")
        do {
            let str = try String(contentsOf: finalDestUrl)
            let lists = str.split(separator: "^")
            if lists.count == 4{
                let watch = lists[0].split(separator: "@")
                WatchListTVC.addList.removeAll()
                var tempArr : [String] = []
                for title in watch{
                    tempArr.append(String(describing: title))
                }
                let watchPoster = lists[1].split(separator: "@")
                var _tempArr : [String] = []
                for poster in watchPoster{
                    _tempArr.append(String(describing: poster))
                }
                var i = 0
                while i < min(tempArr.count, _tempArr.count){
                    WatchListTVC.addList.append([tempArr[i], _tempArr[i]])
                    i += 1
                }
                let seen = lists[2].split(separator: "@")
                WatchListTVC.seenList.removeAll()
                var __tempArr : [String] = []
                for title in seen{
                    __tempArr.append(String(describing: title))
                }
                let seenPoster = lists[3].split(separator: "@")
                var ___tempArr : [String] = []
                for poster in seenPoster{
                    ___tempArr.append(String(describing: poster))
                }
                i = 0
                while i < min(__tempArr.count, ___tempArr.count){
                    WatchListTVC.seenList.append([__tempArr[i], ___tempArr[i]])
                    i += 1
                }
            }
        } catch {
            print("Error")
        }
        tableView.reloadData()
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
        let finalDestUrl : URL = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]).appendingPathComponent("watchlist.txt")
        do {
            var str = ""
            var i = 0
            for entry in WatchListTVC.addList{
                str.append(entry[0])
                i += 1
                if i != WatchListTVC.addList.count {
                    str.append("@")
                }
            }
            str.append("^")
            i = 0
            for entry in WatchListTVC.addList{
                str.append(entry[1])
                i += 1
                if i != WatchListTVC.addList.count {
                    str.append("@")
                }
            }
            str.append("^")
            i = 0
            for entry in WatchListTVC.seenList{
                str.append(entry[0])
                i += 1
                if i != WatchListTVC.seenList.count{
                    str.append("@")
                }
            }
            str.append("^")
            i = 0
            for entry in WatchListTVC.seenList{
                str.append(entry[1])
                i += 1
                if i != WatchListTVC.seenList.count{
                    str.append("@")
                }
            }
            print(str)
            try str.write(to: finalDestUrl, atomically: true, encoding: .utf8)
        } catch {
            print("Error")
        }
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

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.section == 0{
                WatchListTVC.addList.remove(at: indexPath.row)
            }
            else{
                WatchListTVC.seenList.remove(at:indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
