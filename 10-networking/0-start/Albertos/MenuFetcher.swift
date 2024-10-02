//
//  MenuFetcher.swift
//  Albertos
//
//  Created by Andrea Garau on 02/10/24.
//

import Combine
import Foundation

class MenuFetcher: MenuFetching {
    
    let baseUrl: String
    let networkFetching: NetworkFetching
    
    init(baseUrl: String = "https://raw.githubusercontent.com", networkFetching: NetworkFetching) {
        self.baseUrl = baseUrl
        self.networkFetching = networkFetching
    }
    
    func fetchMenu() -> AnyPublisher<[MenuItem], any Error> {
        let url = URL(string: "\(baseUrl)/mokagio/tddinswift_fake_api/refs/heads/trunk/menu_response.json")!
        
        return networkFetching
            .load(URLRequest(url: url))
            .decode(type: [MenuItem].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
