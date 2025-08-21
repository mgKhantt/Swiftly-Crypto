//
//  NetworkingManager.swift
//  SwiftlyCrypto
//
//  Created by Khant Phone Naing on 21/08/2025.
//

import Foundation
import Combine // Combine framework is used for reactive programming and handling asynchronous events.

class NetworkingManager {
    
    // MARK: - Networking Errors
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL) // Thrown when the HTTP response status code is not in the 200-299 range
        case unKnown // Catch-all for any unknown errors
        
        // Provides a human-readable description of the error
        var errorDescription: String? {
            switch self {
                case .badURLResponse(url: let url): return "[🔥] Bad URL Response from: \(url)"
                case .unKnown: return "[⚠️] Unknown error occurred."
            }
        }
    }
    
    // MARK: - Download Data
    /// Downloads data from the given URL and returns a publisher that emits Data or Error
    /// - Parameter url: The URL to fetch data from
    /// - Returns: An AnyPublisher<Data, Error>
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url) // Create a data task publisher
            .subscribe(on: DispatchQueue.global(qos: .default)) // Perform network call on background thread
            .tryMap { try handleURLResponse(output: $0, url: url) } // Validate response and extract data
            .receive(on: DispatchQueue.main) // Switch back to main thread for UI updates
            .eraseToAnyPublisher() // Erase type to AnyPublisher to hide internal details
    }
    
    // MARK: - Handle URL Response
    /// Checks HTTP response and throws an error if the status code is invalid
    /// - Parameters:
    ///   - output: Output from URLSession.DataTaskPublisher
    ///   - url: The original URL
    /// - Returns: Data from the response if successful
    /// - Throws: NetworkingError.badURLResponse if status code is not 200-299
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        // Ensure the response is HTTP and status code is in 200...299
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data // Return the actual data
    }
    
    // MARK: - Handle Completion
    /// Handles completion events from a Combine publisher
    /// - Parameter completion: Subscribers.Completion<Error>
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
            case .finished:
                // Publisher finished successfully
                break
            case .failure(let error):
                // Print localized error message
                print(error.localizedDescription)
        }
    }
}
