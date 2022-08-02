import Alamofire
import Combine
import Foundation

public struct RATPNetworkError: Error {
    let status: String
    let message: String
}

public struct RATPNetwork<Item: Codable> {

    public init() { }

    public func request(url: URL) -> AnyPublisher<Item, RATPNetworkError> {
        Future<Item, RATPNetworkError> { promise in
            do {
                AF.request(url,
                           method: .get, encoding: JSONEncoding.default)
                .validate()
                .responseDecodable(completionHandler: { (response : AFDataResponse<Item>) in
                    switch response.result {

                    case .success(let data):
                        promise(.success(data))

                    case .failure(let error):
                        promise(.failure(RATPNetworkError(status: "\(error.responseCode ?? -1)",
                                                          message: error.localizedDescription)))
                    }

                })

            }
        }
        .eraseToAnyPublisher()
    }

}
