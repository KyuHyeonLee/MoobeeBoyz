//
//  HomeTVC.swift
//  Moobee Boyz
//
//  Created by Jacob McKinnis on 11/12/18.
//  Copyright © 2018 COMP401. All rights reserved.
//

import UIKit

class HomeTVC: UITableViewController, cellDelegate, URLSessionDelegate, URLSessionDownloadDelegate {
    
    var apiKeys: [String] = ["e6d495", "7cc1a35f"]
    
    var closureSort : (([String], [String]) -> Bool) = {
        (s1: [String], s2: [String]) -> Bool in
            return s1[2] > s2[2]
    }
    
    var tmdbUpcoming = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=b29527a69e60d6e3c0dd359bd8ecd99f")
    
    var tmdbCurrent = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=b29527a69e60d6e3c0dd359bd8ecd99f")
    
    //https://api.themoviedb.org/3/movie/{movie_id}?api_key=b29527a69e60d6e3c0dd359bd8ecd99f
    
    //http://image.tmdb.org/t/p/w185/{poster}
    
    @objc dynamic var current : [[String]] = [] //title, image, rating, id
    @objc dynamic var upcoming : [[String]] = [] //title, image, rating, id
    var curInd : Int = 0
    let sectionTitles: [String] = ["Current Playing", "Will Play Soon"]
    
    
    var finalDestUrl : URL = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]).appendingPathComponent("ratings.txt")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        
        do {
            let str = "4.2/5.0"
            try str.write(to: finalDestUrl, atomically: true, encoding: .utf8)
        } catch {
            print("Error")
        }
        
        
        self.addObserver(self, forKeyPath: "current", options: [.old, .new], context: nil)
        self.addObserver(self, forKeyPath: "upcoming", options: [.old, .new], context: nil)

        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        let dtask : URLSessionDownloadTask = session.downloadTask(with: tmdbCurrent!)
        dtask.resume()
        let dtask2 : URLSessionDownloadTask = session.downloadTask(with: tmdbUpcoming!)
        dtask2.resume()
    }
    
    func callSegue(ind : Int) {
        curInd = ind
        self.performSegue(withIdentifier: "toMovie", sender: nil)
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "current")
        self.removeObserver(self, forKeyPath: "upcoming")
    }

    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?){
        //print("reloaded")
        self.tableView.reloadData()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        //print("Finished downloading!")
        
        do {
            let data = try Data(contentsOf: location)
            let obj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : AnyObject]
            let items = obj["results"] as! [[String: AnyObject]]
            for movie in items {
                if (movie["title"] as! String != "Dragon Ball Super: Broly") {
                    let posterURL = "https://image.tmdb.org/t/p/w185/\(movie["poster_path"] as! String)"
                    //print(posterURL)
                    DispatchQueue.main.async {
                        if downloadTask.taskIdentifier == 1 {
                            self.current.append(
                                [movie["title"] as! String,
                                 posterURL,
                                 String(Float(truncating: movie["vote_average"] as! NSNumber) / 2),
                                 String(movie["id"] as! Int)]
                            )
                        } else {
                            self.upcoming.append(
                                [movie["title"] as! String,
                                 posterURL,
                                 String(Float(truncating: movie["vote_average"] as! NSNumber) / 2),
                                 String(movie["id"] as! Int)]
                            )
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                if downloadTask.taskIdentifier == 1 {
                    self.current = self.current.sorted(by: self.closureSort)
                    self.current = Array(self.current.prefix(6))
                } else {
                    for movie in self.current {
                        self.upcoming = self.upcoming.filter({$0 != movie})
                    }
                    self.upcoming = self.upcoming.sorted(by: self.closureSort)
                    self.upcoming = Array(self.upcoming.prefix(6))
                }
            }
        } catch {
            print("Download error")
        }
 
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        //print("total written: \(totalBytesWritten/totalBytesExpectedToWrite)")
    }
    
    
    // MARK: - Table view data source
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "HOME"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return current.count / 2
        } else {
            return upcoming.count / 2
        }
    }
    
    func loadImage(image : UIImageView, url : String) {
        let url = URL(string: url)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                image.image = UIImage(data: data!)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieCell
        
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 4
        let borderColor: UIColor = #colorLiteral(red: 0.03531658649, green: 0.05483096093, blue: 0.1286598742, alpha: 1)
        cell.layer.borderColor = borderColor.cgColor
        
        let num = indexPath.row * 2
        if(indexPath.section == 0) {
            cell.title.text = current[num][0]
            cell.title2.text = current[num + 1][0]
            loadImage(image: cell.movieImage, url: current[num][1])
            loadImage(image: cell.movieImage2, url: current[num + 1][1])
            cell.rating.text = current[num][2]
            cell.rating2.text = current[num + 1][2]
            //cell.movieImage.image = UIImage(named: currentImg[num])
            //cell.movieImage2.image = UIImage(named: currentImg[num + 1])
        } else {
            cell.title.text = upcoming[num][0]
            cell.title2.text = upcoming[num + 1][0]
            loadImage(image: cell.movieImage, url: upcoming[num][1])
            loadImage(image: cell.movieImage2, url: upcoming[num + 1][1])
            cell.rating.text = upcoming[num][2]
            cell.rating2.text = upcoming[num + 1][2]
            /*cell.title.text = upcoming[num]
            cell.title2.text = upcoming[num + 1]
            cell.movieImage.image = UIImage(named: upcomingImg[num])
            cell.movieImage2.image = UIImage(named: upcomingImg[num + 1])*/
        }
        
        do {
            let str = try String(contentsOf: finalDestUrl)
            //cell.rating.text = str
            //cell.rating2.text = str
        } catch {
            print("Error")
        }
        cell.delegate = self
        
        //***JAKE, What is the purpose of this..?
        cell.index = (indexPath.section * 6) + (indexPath.row * 2)
        
        return cell
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
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SearchResultVC
        let key = Int.random(in: 0 ..< apiKeys.count)
        var movieTitle = ""
        var imageLoc = ""
        
        if curInd > 5 {
            movieTitle = upcoming[curInd - 6][0]
            imageLoc = upcoming[curInd - 6][1]
        } else {
            movieTitle = current[curInd][0]
            imageLoc = current[curInd][1]
        }
        
        let queryTitle = movieTitle.replacingOccurrences(of: " ", with: "+")
        destination.query = "https://omdbapi.com/?apikey=\(apiKeys[key])&t=\(queryTitle)"
        destination.searchResult = SearchResults(name: movieTitle, imageLoc: imageLoc)
    }

}
