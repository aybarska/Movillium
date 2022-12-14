//
//  MovieModel.swift
//  Movillium
//
//  Created by Ayberk Mogol on 11.11.2022.
//

import Foundation

protocol MoviesModelProtocol:AnyObject {
    func didDataFetchProcessFinish(isSuccess: Bool, isUpcoming: Bool)
}

class MovieModel {
    weak var delegate: MoviesModelProtocol?
    var movies: [Result] = []
    
    func fetchData(url: String, isUpcoming: Bool) {
        
        // MARK: Get Movies Api
            print("fetch")
            ApiManager.getApiResponse(urlPath: url) { data, error in
                if error != nil {
                    print("model")
                    print(error!.localizedDescription)
                    self.delegate?.didDataFetchProcessFinish(isSuccess: false, isUpcoming: true)
                } else {
                    if let data = data,
                       let moviesList = self.parseLogic(data: data) {
                        print("data")
                        self.movies = moviesList
                        self.delegate?.didDataFetchProcessFinish(isSuccess: true, isUpcoming: isUpcoming)
                    }
                }
            }

    }
    
    
    
    private func parseLogic(data:Data) -> [Result]? {
                    do {
                        let jsonDecoder = JSONDecoder()
                        print("decode")
                        let moviesData = try jsonDecoder.decode(Movies.self, from: data)
                        return moviesData.results
                    } catch {
                        self.delegate?.didDataFetchProcessFinish(isSuccess: false, isUpcoming: false)
                        return nil
                    }
    
}
    
}
