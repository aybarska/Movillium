//
//  DetailsModel.swift
//  Movillium
//
//  Created by Ayberk Mogol on 11.11.2022.
//

import Foundation
import FirebaseAnalytics

protocol DetailsModelProtocol:AnyObject {
    func didDataFetchProcessFinish(isSuccess: Bool)
}

class DetailsModel {
    weak var delegate: DetailsModelProtocol?
    var movie: Details?
    
    
    func fetchData(url: String) {
        
        // MARK: Get Movies Api
            print("fetch")
            ApiManager.getApiResponse(urlPath: url) { data, error in
                if error != nil {
                    print("model")
                    print(error!.localizedDescription)
                } else {
                    if let data = data,
                       let movie = self.parseLogic(data: data) {
                        print("data")
                        self.movie = movie
                        self.sendFirebaseEvent(name: self.movie?.originalTitle ?? "Error in fetchData")
                        self.delegate?.didDataFetchProcessFinish(isSuccess: true)
                    }
                }
            }

    }
    
    private func sendFirebaseEvent(name: String) {
        //SEND firebase analytics
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
          AnalyticsParameterItemName: name,
          AnalyticsParameterContentType: "movie"
          ])
    }
    
    private func parseLogic(data:Data) -> Details? {
                    do {
                        let jsonDecoder = JSONDecoder()
                        print("decode")
                        let movieData = try jsonDecoder.decode(Details.self, from: data)
                        return movieData
                    } catch {
                        self.delegate?.didDataFetchProcessFinish(isSuccess: false)
                        return nil
                    }
    
}
    
}
