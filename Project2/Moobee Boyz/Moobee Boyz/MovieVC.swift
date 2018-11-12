//
//  MovieVC.swift
//  Moobee Boyz
//
//  Created by Jacob McKinnis on 11/12/18.
//  Copyright © 2018 COMP401. All rights reserved.
//

import UIKit

class MovieVC: UIViewController {

    @IBOutlet weak var movieTitle: UILabel!
    
    var movTitle : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitle.text = movTitle
        // Do any additional setup after loading the view.
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
