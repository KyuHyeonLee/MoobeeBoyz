//
//  MovieCell.swift
//  Moobee Boyz
//
//  Created by Jacob McKinnis on 11/12/18.
//  Copyright © 2018 COMP401. All rights reserved.
//

import UIKit

protocol cellDelegate {
    func callSegue(ind : Int)
}

class MovieCell: UITableViewCell {

    var delegate : cellDelegate!
    var index : Int = 0
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBAction func Area1Tap(_ sender: Any) {
        //print(index)
        if self.delegate != nil {
            self.delegate.callSegue(ind : index)
        }
    }
    
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var rating2: UILabel!
    @IBOutlet weak var movieImage2: UIImageView!
    @IBAction func Area2Tap(_ sender: Any) {
        //print(index + 1)
        if self.delegate != nil {
            self.delegate.callSegue(ind : index + 1)
        }
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
