//
//  AsyncAwaitViewModel.swift
//  APICallWays
//
//  Created by M1 on 01.12.2024.
//

import Foundation

protocol DataUpdateProtocolAsyncAwait: AnyObject {
    func updateData()
    func showError(message: String)
}

final class AsyncAwaitViewModel {
    private var asyncAwaitService: AsyncAwaitService
    
    weak var delegate: DataUpdateProtocolAsyncAwait?
    
    /* second way to communicate to objects with closures (without delegate)*/
    // var onDataUpdate: (() -> Void)?
    
    // var onError: ((String) -> Void)?
    
    var downloadedData: [Posts] = []
    
    init(asyncAwaitService: AsyncAwaitService) {
        self.asyncAwaitService = asyncAwaitService
        Task {
            await fetchData()
        }
    }
    
    private func fetchData() async {
        let url = "https://jsonplaceholder.typicode.com/posts"
        do {
            let data = try await asyncAwaitService.fetchData(urlString: url, type: [Posts].self)
            self.downloadedData = data
            delegate?.updateData()
            // self.onDataUpdate?()
        } catch let error as NetworkError {
            let errorMessage = handleError(error)
            delegate?.showError(message: errorMessage)
            // self.onError?(errorMessage)
        } catch {
            delegate?.showError(message: error.localizedDescription)
            // self.onError?(errorMessage)
        }
    }
    
    private func handleError(_ error: NetworkError) -> String {
        switch error {
        case .urlError:
            return "Invalid URL."
        case .decodeError:
            return "Failed to decode the response."
        case .wrongResponse:
            return "Received an invalid response."
        case .wrongStatusCode(let code):
            return "Unexpected status code: \(code)."
        }
    }
}
