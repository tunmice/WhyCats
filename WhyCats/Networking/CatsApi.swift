//

//

import Foundation

enum CatsApi {
    case breeds
    
}

extension CatsApi: EndpointType {
    var path: String {
        switch self {
        case .breeds:
            return "breeds"
            
        }
    }
    
    
    
    var baseURL: URL {
        return URL(string: "https://api.thecatapi.com/v1/")!
    }
}
