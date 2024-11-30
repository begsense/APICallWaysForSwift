# APICallWaysForSwift

A Swift project demonstrating three different ways to call an API:
1. Using **escaping closures**.
2. Using **Combine**.
3. Using **async/await**.

## Features
- Fetch data from [JSONPlaceholder](https://jsonplaceholder.typicode.com/posts).
- Display data in a `UITableView`.
- Modular implementation with reusable patterns.

## Project Structure
- **Services**: Handles API calls using different approaches (`ClosureService`, `CombineService`, `AsyncAwaitService`).
- **ViewModels**: Manages data and business logic for each API method.
- **Views**: Updates the user interface (`ClosureView`, `CombineView`, `AsyncAwaitView`).

## API Methods

### 1. Escaping Closures
- Demonstrates the traditional approach with completion handlers.
- Example:
    ```swift
       dataService.fetchData(urlString: url) { (result: Result<[Posts], Error>) in
            switch result {
            case .success(let data):
                self.downloadedData = data
                self.delegate?.updateData()
            case .failure(let error):
                let errorMessage = self.handleError(error)
                self.delegate?.showError(message: errorMessage)
            }
        }
    ```

### 2. Combine
- Uses **Combine Framework** for reactive programming.
- Example:
    ```swift
        combineService.fetchData(urlString: url, type: [Posts].self)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    let errorMessage = self?.handleError(error) ?? "Unknown error"
                    self?.delegate?.showError(message: errorMessage)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] fetchedData in
                self?.downloadedData = fetchedData
                self?.delegate?.updateData()
            }
            .store(in: &cancellable)
    ```

### 3. Async/Await
- Leverages modern Swift syntax for clean and readable code.
- Example:
    ```swift
        do {
            let data = try await asyncAwaitService.fetchData(urlString: url, type: [Posts].self)
            self.downloadedData = data
            delegate?.updateData()
        } catch let error as NetworkError {
            let errorMessage = handleError(error)
            delegate?.showError(message: errorMessage)
        } catch {
            delegate?.showError(message: error.localizedDescription)
        }
    ```

## How to Run
1. Clone the repository:
    ```bash
    git clone https://github.com/begsense/APICallWaysForSwift.git
    ```
2. Open the project in Xcode.
3. Select a simulator or device.
4. Build and run the app.

## Requirements
- iOS 14.0+
- Swift 5.5+
- Xcode 14+

## Contact
Created by **BegSense**. Feel free to reach out for feedback or collaboration!

---
