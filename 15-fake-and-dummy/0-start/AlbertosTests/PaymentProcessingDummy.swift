//
//  PaymentProcessingDummy.swift
//  AlbertosTests
//
//  Created by Andrea Garau on 09/10/24.
//

@testable import Albertos
import Combine
import Foundation

class PaymentProcessingDummy: PaymentProcessing {
    func process(order: Order) -> AnyPublisher<Void, any Error> {
        return Result<Void, Error>.success(())
            .publisher
            .eraseToAnyPublisher()
    }
}
