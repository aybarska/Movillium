//
//  PhotosCollectionViewCell.swift
//  alligator
//
//  Created by Ayberk M on 21.09.2022.
//

import UIKit


class PhotosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imagelView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    static let identifier = "PhotosCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func draw(_ rect: CGRect) {
        //make gradient size equal to imageview size
        super.draw(rect)
        drawGradient(desiredView: imagelView)
    }
    
    static func nib()-> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
                
    private func drawGradient(desiredView: UIView) {
        //creates new view and puts front of desired one with gradient
        var grColor = UIColor.black.cgColor
        if self.traitCollection.userInterfaceStyle == .dark {
            //if client is in dark mode, gradient will be grayish
            grColor = UIColor.darkGray.cgColor
        }
        
        let view = UIView(frame: desiredView.frame)
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor.clear.cgColor, grColor]
        gradient.locations = [0.0, 1.0]
        
        view.layer.insertSublayer(gradient, at: 0)
        view.alpha = 0.6
        desiredView.addSubview(view)
        desiredView.bringSubviewToFront(view)
    }
}
