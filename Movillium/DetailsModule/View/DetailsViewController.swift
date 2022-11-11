//
//  DetailsViewController.swift
//  Movillium
//
//  Created by Ayberk Mogol on 11.11.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    var id: Int? = 0
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(id!)
    }



}
