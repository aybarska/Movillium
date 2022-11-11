//
//  ApiManager.swift
//  Movillium
//
//  Created by Ayberk Mogol on 10.11.2022.
//

import Foundation
import Alamofire

class ApiManager {
    
    class func getApiResponse(urlPath: String, completionHandler: @escaping (Data?, Error?) -> Void ) {
   
      
        guard let urlStr = URL.init(string: urlPath) else { return }
        
        let task = AF.request(urlStr, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
                    .responseJSON(completionHandler: { response in
                        switch response.result {
                        case .success:
                            let data = response.data
                            completionHandler(data, nil)
                        case .failure(let error):
                            print(error)
                            completionHandler(nil, error)
                        }
                    })
        task.resume()

    }
}
