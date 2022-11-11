//
//  MainTableViewCell.swift
//  Moovies-uikit
//
//  Created by Ayberk Mogol on 20.10.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    
}
