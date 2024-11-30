//
//  EClosureViewModel.swift
//  APICallWays
//
//  Created by M1 on 30.11.2024.
//

import Foundation

protocol DataUpdateProtocol: AnyObject {
    func updateData()
    func showError(message: String)
}

final class EClosureViewModel {
    
    private var eClosureService: EClosureService
    
    weak var delegate: DataUpdateProtocol?
    
    /* second way to communicate to objects with closures (without delegate)*/
    // var onDataUpdate: (() -> Void)?
    
    // var onError: ((String) -> Void)?
    
    var downloadedData: [Posts] = []
    
    
    init(dataService: EClosureService) {
        self.eClosureService = dataService
        fetchData()
    }
    
    private func fetchData() {
        let url = "https://jsonplaceholder.typicode.com/posts"
        
        eClosureService.fetchData(urlString: url) { (result: Result<[Posts], Error>) in
            switch result {
            case .success(let data):
                self.downloadedData = data
                self.delegate?.updateData()
                // self.onDataUpdate?()
            case .failure(let error):
                let errorMessage = self.handleError(error)
                self.delegate?.showError(message: errorMessage)
                // self.onError?(errorMessage)
            }
        }
    }
    
    private func handleError(_ error: Error) -> String {
        if let networkError = error as? NetworkError {
            switch networkError {
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
        return error.localizedDescription
    }
}
