//
//  EClosureService 2.swift
//  APICallWays
//
//  Created by M1 on 30.11.2024.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case decodeError
    case wrongResponse
    case wrongStatusCode(code: Int)
}

public class EClosureService {
    public func fetchData<T: Decodable>(urlString: String, completion: @escaping (Result<T,Error>) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if error != nil {
                completion(.failure(NetworkError.urlError))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.wrongResponse))
                return
            }
            
            guard response.statusCode >= 200 && response.statusCode < 300 else {
                completion(.failure(NetworkError.wrongStatusCode(code: response.statusCode)))
                return
            }
            
            guard let data else { return }
            
            do {
                let fetchedData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(fetchedData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.decodeError))
                }
            }
        }.resume()
    }
}


