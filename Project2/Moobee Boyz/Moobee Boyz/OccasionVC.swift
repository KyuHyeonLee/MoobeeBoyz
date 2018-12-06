//
//  OccasionVC.swift
//  Moobee Boyz
//
//  Created by COMP401 on 11/21/18.
//  Copyright © 2018 COMP401. All rights reserved.
//

import UIKit


    
class OccasionCell: UITableViewCell {


    var _image_ : UIImage?
    
    @IBOutlet var OccasionImages: UIImageView?
    @IBOutlet var LabelText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}


class OccasionVC :  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet var _tableView: UITableView!
    
    
    var images = [#imageLiteral(resourceName: "image5"), #imageLiteral(resourceName: "image2"), #imageLiteral(resourceName: "image3"), #imageLiteral(resourceName: "image1"), #imageLiteral(resourceName: "image4")]
    var Occasions = ["WWI & WWII", "CLASSIC", "HALLOWEEN", "CHRISTMAS", "NEW YEAR"]
    
    
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MOCell", for: indexPath) as! OccasionCell
        cell.OccasionImages?.image = images[indexPath.row]
        cell.LabelText?.text = Occasions[indexPath.row]
        
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        _tableView.delegate = self
        _tableView.dataSource = self
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "BY OCCASION"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }
    
    
    
    
    
}
