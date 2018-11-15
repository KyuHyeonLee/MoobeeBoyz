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
    
    @IBOutlet weak var _tableView : UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RankingCell
        cell._text_ = "Crazy Rich Asians\n\(indexPath.row + 1)"
        cell._image_ = UIImage(named: "crazy.jpeg")
        cell.updateData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        _tableView.delegate = self
        _tableView.dataSource = self
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
