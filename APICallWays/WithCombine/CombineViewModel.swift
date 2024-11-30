//
//  CombineViewModel.swift
//  APICallWays
//
//  Created by M1 on 30.11.2024.
//

import Foundation
import Combine

protocol DataUpdateProtocolCombine: AnyObject {
    func updateData()
    func showError(message: String)
}

final class CombineViewModel {
    
    var combineService: CombineService
    
    var cancellable = Set<AnyCancellable>()
    
    weak var delegate: DataUpdateProtocolCombine?
    
    var downloadedData: [Posts] = []
    
    /* second way to communicate to objects with closures (without delegate)*/
    // var onDataUpdate: (() -> Void)?
    
    // var onError: ((String) -> Void)?
    
    init(combineService: CombineService) {
        self.combineService = combineService
        fetchData()
    }
    
    private func fetchData() {
        let url = "https://jsonplaceholder.typicode.com/posts"
        
        combineService.fetchData(urlString: url, type: [Posts].self)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    let errorMessage = self?.handleError(error) ?? "Unknown error"
                    self?.delegate?.showError(message: errorMessage)
                    // self.onError?(errorMessage)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] fetchedData in
                self?.downloadedData = fetchedData
                self?.delegate?.updateData()
                // self.onDataUpdate?()
            }
            .store(in: &cancellable)
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
