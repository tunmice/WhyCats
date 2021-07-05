//
//  CatsRepository.swift
//  WhyCats
//
//  Created by macos on 02/07/2021.
//

import Foundation

protocol CatsRepo {
    func fetchCats(completion:@escaping ((_ response: NetworkResult<[CatsModel]>) -> Void))
    func fetchCatsList() -> [AllCatsCoreDataModel]
    
}

class CatsRepoImpl: BaseRepository, CatsRepo{
    
    
    
    private let catsDao:CatsDao

     init(catsDao:CatsDao) {
        self.catsDao = catsDao
    }

    func fetchCatsList() -> [AllCatsCoreDataModel] {
        return self.catsDao.fetchCats()
    }
    
    
    
    func fetchCats(completion: @escaping ((NetworkResult<[CatsModel]>) -> Void)) {
        networkHelper.performGetRequest(endpoint: .breeds, returnType: [CatsModel].self, completion: { response in
            print("they break all")
            if case let .success(data) = response {
                print("E don Show")
                self.saveCatsList(cats: data)
                completion(.success(data))
            }  else if case let .error(error) = response {
                print("E never show o")
                completion(.error(error))
            }
        })
    }
    
    func saveCatsList(cats: [CatsModel]) {
        guard cats != nil else {
            return
        }
        _ = catsDao.insertCats(withCats: cats)
    }
    
}
