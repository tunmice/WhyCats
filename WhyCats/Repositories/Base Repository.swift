//
//  Base Repository.swift
//  Flenjor
//
//  Created by macos on 21/04/2021.
//

import Foundation

class BaseRepository {
    let networkHelper = Networking()
    
    func makeGETNetworkRequest<T:Codable>(endPoint:CatsApi,completion: @escaping ((NetworkResult<T>) -> Void),successCondition:@escaping (T) -> Bool,errorMessage:@escaping (T)->String) {
         networkHelper.performGetRequest(endpoint: endPoint, returnType: T.self, completion: { response in
            if case let .success(data) = response{
                if(successCondition(data)){
                    DispatchQueue.main.async {
                        completion(.success(data))
                    }
                } else{
                    completion(.failure(errorMessage(data)))
                }} else if case let .error(error) = response {
                completion(.error(error))
            }
        })
     }
    
    
    
}
