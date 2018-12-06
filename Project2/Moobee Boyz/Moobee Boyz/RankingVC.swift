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
    
    let RankingSectionTitle: [String] = ["Top 5 Movies"]
    
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
        navigationController?.navigationBar.isTranslucent = false
        _tableView.delegate = self
        _tableView.dataSource = self
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
