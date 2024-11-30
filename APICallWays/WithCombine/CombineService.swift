//
//  CombineService.swift
//  APICallWays
//
//  Created by M1 on 30.11.2024.
//

import Foundation
import Combine

final class CombineService {
    public func fetchData<T: Decodable>(urlString: String, type: T.Type) -> AnyPublisher<T, NetworkError> {
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.urlError).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard
                    let response = response as? HTTPURLResponse else {
                    throw NetworkError.wrongResponse
                }
                
                guard response.statusCode >= 200 && response.statusCode < 300 else {
                    throw NetworkError.wrongStatusCode(code: response.statusCode)
                }
                
                return data
            }
            .mapError { error -> NetworkError in
                if let networkError = error as? NetworkError {
                    return networkError
                } else if error is DecodingError {
                    return NetworkError.decodeError
                } else {
                    return NetworkError.urlError
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { _ in NetworkError.decodeError }
            .eraseToAnyPublisher()
    }
}
