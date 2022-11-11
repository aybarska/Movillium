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
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        shapeImage(desiredImage: posterImageView)
    }


    private func shapeImage(desiredImage: UIView) {
        //cool image shape
        desiredImage.layer.cornerRadius = 20
        desiredImage.clipsToBounds = true
        desiredImage.layer.shadowRadius = 20
        desiredImage.layer.shadowOpacity = 1.0
        desiredImage.layer.shadowOffset = CGSize(width: 3, height: 3)
        desiredImage.layer.shadowColor = UIColor.gray.cgColor
    }
}
