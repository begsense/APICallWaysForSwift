//
//  AsyncAwaitService.swift
//  APICallWays
//
//  Created by M1 on 01.12.2024.
//

import Foundation

final class AsyncAwaitService {
    public func fetchData<T: Decodable>(urlString: String, type: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else { throw NetworkError.urlError }
        
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.wrongResponse
        }
        
        guard response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkError.wrongStatusCode(code: response.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodeError
        }
    }
}
