//
//  HomeTVC.swift
//  Moobee Boyz
//
//  Created by Jacob McKinnis on 11/12/18.
//  Copyright © 2018 COMP401. All rights reserved.
//

import UIKit

class HomeTVC: UITableViewController, cellDelegate {
    
    func callSegue(ind : Int) {
        curInd = ind
        self.performSegue(withIdentifier: "toMovie", sender: nil)
    }

    let current : [String] = ["The nutcracker and the four realms", "First man", "Incredibles 2", "Crazy Rich Asians", "Bohemian Rhapsody", "Venom"]
    
    let upcoming : [String] = ["Old Man and Gun","Hunter Killer","Goosebumps 2","Nobody's Fool","Small Foot","The Nun"]
    
    let currentImg : [String] = ["nutcracker.jpg", "first.jpeg", "inc2.jpeg", "crazy.jpeg", "queen.jpg", "venom.jpg"]
    
    let upcomingImg : [String] = ["old.jpeg","hunt.jpeg","goosebumps2.jpeg","noFool.jpg","small.jpeg","nun.jpeg"]
    
    var curInd : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    func hexToColor (hex: Int) -> UIColor {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0xFF00) >> 8) / 255.0
        let blue = Double((hex & 0xFF)) / 255.0
        let color: UIColor = UIColor( red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha:CGFloat(1.0))
        return color
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieCell
        
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 4
        let borderColor: UIColor = hexToColor(hex: 0x090E21)
        cell.layer.borderColor = borderColor.cgColor
        
        let num = indexPath.row * 2
        if(indexPath.section == 0) {
            cell.title.text = current[num]
            cell.title2.text = current[num + 1]
            cell.movieImage.image = UIImage(named: currentImg[num])
            cell.movieImage2.image = UIImage(named: currentImg[num + 1])
        } else {
            cell.title.text = upcoming[num]
            cell.title2.text = upcoming[num + 1]
            cell.movieImage.image = UIImage(named: upcomingImg[num])
            cell.movieImage2.image = UIImage(named: upcomingImg[num + 1])
        }
        cell.rating.text = "4.2/5.0"
        cell.rating2.text = "4.2/5.0"
        //cell.movieImage.image = UIImage(named: "clock-7.png")
        cell.delegate = self
        cell.index = (indexPath.section * 6) + (indexPath.row * 2)
        
        return cell
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
        let dest = segue.destination as! MovieVC
        if curInd > 5 {
            dest.movTitle = upcoming[curInd - 6]
        } else {
            dest.movTitle = current[curInd]
        }
    }
 

}
