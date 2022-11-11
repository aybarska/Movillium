//
//  MainViewModel.swift
//  Movillium
//
//  Created by Ayberk Mogol on 11.11.2022.
//

import Foundation
import Foundation
protocol MainViewModelViewProtocol:AnyObject {
    func didPlayingCellItemFetch(_ items: [MovieCellViewModel])
    func didUpcomingCellItemFetch(_ items: [MovieCellViewModel])
    func showEmptyView()
    func hideEmptyView()
    func hideLoadingView()
}


class MainViewModel {
    private let model = MovieModel()
    
    weak var viewDelegate: MainViewModelViewProtocol?
    
    init(){
        model.delegate = self
    }
  
    
    
    func didClickItem(at index: Int) {
        let selectedItem = model.movies[index]
        print(selectedItem)
        
    }
    
    func didViewLoad() {
        
        model.fetchData(url: "https://api.themoviedb.org/3/movie/now_playing?api_key=3b70f74f275d84907544e6c393d356e3", isUpcoming: false)
        
        model.fetchData(url: "https://api.themoviedb.org/3/movie/upcoming?api_key=3b70f74f275d84907544e6c393d356e3", isUpcoming: true)
        // true halini de gonder ve viewda List icin de bir protocol calistir
    }
    
    func getData() {
        model.fetchData(url: "https://api.themoviedb.org/3/movie/now_playing?api_key=3b70f74f275d84907544e6c393d356e3", isUpcoming: false)
    }

    
    func movieAtIndex(_ index: Int) -> Result{
        return model.movies[index]
    }
    
}

private extension MainViewModel {
    
    @discardableResult
    func makeViewBasedModel(_ movies: [Result]) -> [MovieCellViewModel] {
        //make data usabe for view
        return movies.map { .init(id: $0.id, poster: $0.posterPath, title: $0.originalTitle, desc: $0.overview, date: $0.releaseDate) }
    }
    
    
}

extension MainViewModel: MoviesModelProtocol {
    func didDataFetchProcessFinish(isSuccess: Bool, isUpcoming: Bool) {
        //data we fetch from api
        if isSuccess {
            let movies = model.movies
            let items = makeViewBasedModel(movies)
            if(items.count == 0) {
                viewDelegate?.showEmptyView()
            } else {
                print(items)
                if(isUpcoming) {
                    viewDelegate?.didUpcomingCellItemFetch(items)
                } else {
                    viewDelegate?.didPlayingCellItemFetch(items)
                }
                
                viewDelegate?.hideEmptyView()
            }
           
        } else {
            viewDelegate?.showEmptyView()
        }

        viewDelegate?.hideLoadingView()
    }
    
}
