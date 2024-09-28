//
//  MenuFetching.swift
//  Albertos
//
//  Created by Andrea Garau on 28/09/24.
//

import Combine

protocol MenuFetching {
    func fetchMenu() -> AnyPublisher<[MenuItem], Error>
}
