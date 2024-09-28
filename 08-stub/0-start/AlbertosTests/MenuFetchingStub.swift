//
//  MenuFetchingStub.swift
//  AlbertosTests
//
//  Created by Andrea Garau on 28/09/24.
//

@testable import Albertos
import Combine
import Foundation

class MenuFetchingStub: MenuFetching {
    let result: Result<[MenuItem], Error>
    
    init(returning result: Result<[MenuItem], Error>) {
        self.result = result
    }
    
    func fetchMenu() -> AnyPublisher<[MenuItem], any Error> {
        return result.publisher
            .delay(for: 0.1, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

class MultipleMenuFetchingStub: MenuFetching {
    let results: [Result<[MenuItem], Error>]
    
    var counter = 0
    
    init(returning results: [Result<[MenuItem], Error>]) {
        self.results = results
    }
    
    func fetchMenu() -> AnyPublisher<[MenuItem], any Error> {
        defer { counter += 1 }
        
        if counter == 0 {
            return results.first!.publisher
                .delay(for: 0.1, scheduler: RunLoop.main)
                .eraseToAnyPublisher()
            
        } else {
            return results.last!.publisher
                .delay(for: 0.1, scheduler: RunLoop.main)
                .eraseToAnyPublisher()
        }
    }
}
