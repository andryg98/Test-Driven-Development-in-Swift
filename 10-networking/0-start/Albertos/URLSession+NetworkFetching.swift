//
//  URLSession+NetworkFetching.swift
//  Albertos
//
//  Created by Andrea Garau on 02/10/24.
//

import Foundation
import Combine

extension URLSession: NetworkFetching {
    func load(_ request: URLRequest) -> AnyPublisher<Data, URLError> {
        return dataTaskPublisher(for: request)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
