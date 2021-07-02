//
//  Networking2.swift
//  QuickGem-ios
//
//  Created by macos on 02/03/2021.
//  Copyright © 2021 macos. All rights reserved.
//

import Foundation

enum NetworkResult<T>{
    case success(T)
    case failure(String)
    case error(Error?)
}


struct Networking {
   
    //MARK:- get request
    
    func performGetRequest<T: Codable>(endpoint: CatsApi,
                                        returnType: T.Type,
                                        completion:@escaping ((_ response: NetworkResult<T>) -> Void)
                                    ) {
        
        let urlString = endpoint.baseURL.appendingPathComponent(endpoint.path).absoluteString.removingPercentEncoding
        guard let urlRequest = URL(string: urlString ?? "") else { return }
        var endpointRequest = URLRequest(url: urlRequest)
            endpointRequest.httpMethod = "GET"
            endpointRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print("Request: \(urlString ?? "")\n")
        
        
        
        let urlSession = URLSession.shared.dataTask(with: endpointRequest) { (data, urlResponse, error) in
            if let _ = error {
                print("Error :\(urlString ?? "") \n\(error?.localizedDescription ?? "Bad request")")
                completion(.error(error))
                return
            }
            guard let data = data else {
                 print("Error :\(urlString ?? "") ")
                completion(.error(nil))
                return
            }
            let response = Responses(data: data)
           
            guard let decoded = response.decode(returnType) else {
                 print("Error Decoding Response : \(urlString ?? "")")
                completion(.error(nil))
                return
            }
            print("Response: \(urlString ?? "") \n \(decoded)\n")
            completion(.success(decoded))
        }
        urlSession.resume()
        
        
        
        
        }
    
    
    
    
    
}
