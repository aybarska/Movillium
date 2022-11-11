//
//  DetailsViewModel.swift
//  Movillium
//
//  Created by Ayberk Mogol on 11.11.2022.
//

import Foundation

protocol DetailsViewModelViewProtocol:AnyObject {
    func didItemFetch(_ items: Details)
    func showEmptyView()
}


class DetailsViewModel {
    private let model = DetailsModel()
  
    weak var viewDelegate: DetailsViewModelViewProtocol?
    
    init(){
        model.delegate = self
    }
 
    func getData(id: Int) {
        model.fetchData(url: "https://api.themoviedb.org/3/movie/\(id)?api_key=3b70f74f275d84907544e6c393d356e3")
    }
}



extension DetailsViewModel: DetailsModelProtocol {
    func didDataFetchProcessFinish(isSuccess: Bool) {
        //data we fetch from api
        if isSuccess {
            let movie = model.movie
            viewDelegate?.didItemFetch(movie!)
        } else {
            viewDelegate?.showEmptyView()
            print("fetch false")
        }

    }
    
}
