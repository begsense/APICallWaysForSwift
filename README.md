# APICallWaysForSwift

A Swift project demonstrating three different ways to call an API:
1. Using **escaping closures**.
2. Using **Combine**.
3. Using **async/await (modern Swift syntax)**.

## Features
- Fetch data from [JSONPlaceholder](https://jsonplaceholder.typicode.com/posts).
- Display data in a `UITableView`.
- Modular implementation with reusable patterns.
- protocol delegates, and closures for managing data flow between components.

## Project Structure
- **Services**: Handles API calls using different approaches (`ClosureService`, `CombineService`, `AsyncAwaitService`).
- **ViewModels**: Manages data and business logic for each API method.
- **Views**: Updates the user interface (`ClosureView`, `CombineView`, `AsyncAwaitView`).

## API Methods

### 1. Escaping Closures
- Demonstrates the traditional approach with completion handlers.
- Example:
    ```swift
       func fetchData<T: Decodable>(urlString: String, completion: @escaping (Result<T,Error>) -> ()) 
    ```

### 2. Combine
- Uses **Combine Framework** for reactive programming.
- Example:
    ```swift
        func fetchData<T: Decodable>(urlString: String, type: T.Type) -> AnyPublisher<T, NetworkError>
    ```

### 3. Async/Await
- Leverages modern Swift syntax for clean and readable code.
- Example:
    ```swift
        func fetchData<T: Decodable>(urlString: String, type: T.Type) async throws -> T
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
