//
//  Base View Model.swift
//  Flenjor
//
//  Created by macos on 21/04/2021.
//

import Foundation
//import RxSwift
class BaseViewModel {
    let userdefaults = UserDefaults.standard
    
    
//    public let error:PublishSubject<String> = PublishSubject()
//    public let isLoading:PublishSubject<Bool> = PublishSubject()
//
//    func makeAPICall <R:Codable,T:Codable>(request:R,apiRequest:(R,@escaping ((_ response: NetworkResult<T>) -> Void)) ->Void,successHandler:PublishSubject<T>){
//        self.isLoading.onNext(true)
//        apiRequest(request,{ response in
//            self.isLoading.onNext(false)
//            if case let .success(data) = response {
//                successHandler.onNext(data)
//            }else if case let .failure(errorMessage) = response {
//                self.isLoading.onNext(false)
//                self.error.onNext(errorMessage)
//            }else if case let .error(error) = response{
//                self.isLoading.onNext(false)
//                self.error.onNext(error?.localizedDescription ?? "Something went wrong")
//            }
//        })
//    }
//
//
    
    
    
    
}
