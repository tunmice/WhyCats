

import Foundation

struct Responses {
    fileprivate var data: Data
    init(data: Data) {
        self.data = data
    }
}

extension Responses {
    public func decode<T: Codable>(_ type: T.Type) -> T? {
        let jsonDecoder = JSONDecoder()
        do {
            let response = try jsonDecoder.decode(T.self, from: data)
            
            return response
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}

