//
//  ApiManager.swift
//  Movillium
//
//  Created by Ayberk Mogol on 10.11.2022.
//

import Foundation

class ApiManager {
    
    class func getApiResponse(urlPath: String, completionHandler: @escaping (Data?, Error?) -> Void ) {
   
        let urlSession = URLSession.shared
        guard let url = URL.init(string: urlPath) else { return }
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            
            if error != nil {
               
                completionHandler(nil, error)
            } else {
                completionHandler(data, nil)
            }
        }
        task.resume()
    }
}
