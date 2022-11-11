//
//  DetailsViewController.swift
//  Movillium
//
//  Created by Ayberk Mogol on 11.11.2022.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {
    
    private let viewModel = DetailsViewModel()
    private var item: Details?
    var id: Int? = 0
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        viewModel.viewDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getData(id: id ?? 0)
    }



}

extension DetailsViewController: DetailsViewModelViewProtocol {
    
    
        
        func didItemFetch(_ items: Details) {
            self.item = items
            DispatchQueue.main.async {
                let imageUrl = "https://image.tmdb.org/t/p/original/" + (self.item?.posterPath ?? "wwemzKWzjKYJFfCeiB57q3r4Bcm.png")
                let rating: String = self.item?.voteAverage.description ?? "0.0"
                self.titleLabel.text = self.item?.originalTitle
                self.descLabel.text = self.item?.overview
                self.ratingLabel.text = String(rating.prefix(3)) + "/10"
                self.imageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "noResult"))
                self.dateLabel.text = "* " + (self.item?.releaseDate ?? "")
            }
        }
        
        func showEmptyView() {
            // has to be in main
            //self.item = []
            DispatchQueue.main.async {
            let noDataImageView = UIImageView(image: UIImage(named: "noResult"))
            noDataImageView.contentMode = .scaleAspectFit
                noDataImageView.backgroundColor = .white
                noDataImageView.frame = self.view.frame
                self.view.addSubview(noDataImageView)
                self.view.bringSubviewToFront(noDataImageView)
                
            }
        }

        
    }
