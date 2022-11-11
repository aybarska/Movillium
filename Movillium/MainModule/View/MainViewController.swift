//
//  MainViewController.swift
//  Movillium
//
//  Created by Ayberk Mogol on 10.11.2022.
//

import UIKit
import SDWebImage

class MainViewController: UIViewController {

    @IBOutlet weak var playingCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
   
    private let viewModel = MainViewModel()
    
    private var currentPlayingItems: [MovieCellViewModel] = []
    private var upcomingItems: [MovieCellViewModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setCollectionView()
         setTableView()
         viewModel.viewDelegate = self
         viewModel.didViewLoad()
    }
    
    

    private func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        playingCollectionView.collectionViewLayout = layout
        playingCollectionView.register(PhotosCollectionViewCell.nib(), forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        playingCollectionView.delegate = self
        playingCollectionView.dataSource = self
        setPageControl()
    }
    
    private func setPageControl() {
        pageControl.numberOfPages = currentPlayingItems.count
    }

    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableViewCell")
        tableView.rowHeight = 230.0
    }

    @IBAction func pageChanged(_ sender: UIPageControl) {
        let page: Int? = sender.currentPage
        var frame: CGRect = self.playingCollectionView.frame
        frame.origin.x = frame.size.width * CGFloat(page ?? 0)
        frame.origin.y = 0
        self.playingCollectionView.scrollRectToVisible(frame, animated: true)
    }
}

extension MainViewController: MainViewModelViewProtocol {
    
        func hideLoadingView() {
            DispatchQueue.main.async {
                //self.activityIndicator.stopAnimating()
            }
        }
    
        
        func didPlayingCellItemFetch(_ items: [MovieCellViewModel]) {
            self.currentPlayingItems = items
            DispatchQueue.main.async {
                self.playingCollectionView.reloadData()
                self.pageControl.numberOfPages = self.currentPlayingItems.count
            }
        }
    
        func didUpcomingCellItemFetch(_ items: [MovieCellViewModel]) {
            self.upcomingItems = items
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        func showEmptyView() {
            // has to be in main
            self.currentPlayingItems = []
            DispatchQueue.main.async {
            let noDataImageView = UIImageView(image: UIImage(named: "noResult"))
                noDataImageView.contentMode = .scaleAspectFit
            self.playingCollectionView.backgroundView = noDataImageView
            self.playingCollectionView.reloadData()
            }
        }
        
        func hideEmptyView() {
            DispatchQueue.main.async {
                self.playingCollectionView.backgroundView?.isHidden = true
                self.playingCollectionView.reloadData()
            }
        }
    

        
    }

extension MainViewController: UITableViewDelegate {
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//          viewModel.didClickItem(at: indexPath.row)
//          tableView.deselectRow(at: indexPath, animated: true)
//          let detailsVC = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
//          detailsVC?.imdbId = items[indexPath.row].imdbID ?? ""
//          self.navigationController?.pushViewController(detailsVC!, animated: true)
      }
  }

  extension MainViewController: UITableViewDataSource {
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return upcomingItems.count
      }
      
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as! MainTableViewCell
         
          let item = upcomingItems[indexPath.row]
          let imageUrl = "https://image.tmdb.org/t/p/original/" + (item.poster ?? "wwemzKWzjKYJFfCeiB57q3r4Bcm.png")
          cell.titleLabel.text = item.title
         // cell.descLabel.text = item.desc
          cell.posterImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "noResult"))

          return cell
      }
      
  }

extension MainViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentPlayingItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = playingCollectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        let item = currentPlayingItems[indexPath.row]
        let imageUrl = "https://image.tmdb.org/t/p/original/" + (item.poster ?? "wwemzKWzjKYJFfCeiB57q3r4Bcm.png")
        cell.titleLabel.text = item.title
        cell.descLabel.text = item.desc
        cell.imagelView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "noResult"))
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
