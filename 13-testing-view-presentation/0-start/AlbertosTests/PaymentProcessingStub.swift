//
//  PaymentProcessingStub.swift
//  AlbertosTests
//
//  Created by Andrea Garau on 09/10/24.
//

@testable import Albertos
import Foundation
import Combine

class PaymentProcessingStub: PaymentProcessing {
    let result: Result<Void, any Error>
    
    init(result: Result<Void, any Error>) {
        self.result = result
    }
    
    func process(order: Albertos.Order) -> AnyPublisher<Void, any Error> {
        return result.publisher
            .delay(for: 0.1, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
