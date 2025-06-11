//
//  NetworkManager.swift
//  CryptoVault
//
//  Created by Hanzla Rafique 9/9/24.
//

import Foundation
import Combine


class NetworkManager {
    
    enum NetworkError: LocalizedError {
        
        case badURLRequest(url: URL)
        case unKnownError
        
        var errorDescription: String {
            
            switch self {
            case .badURLRequest(url: let url): return "[🔥🔥] Bad url request: \(url)"
            case .unKnownError:  return "unKnownError"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, any Error> {
        
        
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap {try dataMap(output: $0, url: url)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func dataMap(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkError.badURLRequest(url: url)
        }
        return output.data
    }
    
    static func handlerCompletion(completion: Subscribers.Completion<Error>) {
        
        switch completion {
        case .finished:
            break
            
        case .failure(let error):
            print(error)
        }
    }
    
}


