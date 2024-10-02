//
//  NetworkFetchingStub.swift
//  AlbertosTests
//
//  Created by Andrea Garau on 02/10/24.
//

@testable import Albertos
import Foundation
import Combine

class NetworkFetchingStub: NetworkFetching {
    private let result: Result<Data, URLError>
    
    init(result: Result<Data, URLError>) {
        self.result = result
    }
    
    func load(_ request: URLRequest) -> AnyPublisher<Data, URLError> {
        return result
            .publisher
            .delay(for: 1.0, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
