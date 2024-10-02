//
//  NetworkFetching.swift
//  Albertos
//
//  Created by Andrea Garau on 02/10/24.
//

import Combine
import Foundation

protocol NetworkFetching {
    func load(_ request: URLRequest) -> AnyPublisher<Data, URLError>
}
