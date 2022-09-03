//
//  NetworkingManager.swift
//  CryptoTracker
//
//  Created by Robert Basamac on 14.08.2022.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        // by conforming to LocalizedError we can give it customised localized description
        
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):
                return "[🔥] Bad response from URL: \(url)"
            case .unknown:
                return "[⚠️] Unknown error occured."
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, any Error> {
        
//        1. create the Publisher
        return URLSession.shared.dataTaskPublisher(for: url)
        
//            2. subscribe publisher on background thread (this is done by default so this step can be omitted)
//            .subscribe(on: DispatchQueue.global(qos: .default))
        
//            3. receive on main thread (needed in order to update the UI) -> move this to receive on main thread much later and do more work on global thread
//            .receive(on: DispatchQueue.main)

//            4. check that the data is good (using tryMap)
//            .tryMap { (output) -> Data in
//                guard let response = output.response as? HTTPURLResponse,
//                      response.statusCode >= 200 && response.statusCode < 300 else {
//                    throw URLError(.badServerResponse)
//                }
//                return output.data
//            }
            .tryMap({ try handleUrlResponse(output: $0, url: url) })
            .retry(3)
            .eraseToAnyPublisher() // will take the publisher and convert it to AnyPublisher -> we can change the return data type of the function
    }
    
    static func handleUrlResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
