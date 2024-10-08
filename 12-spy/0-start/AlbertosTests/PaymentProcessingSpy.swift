//
//  PaymentProcessingSpy.swift
//  AlbertosTests
//
//  Created by Andrea Garau on 07/10/24.
//

@testable import Albertos
import Combine

class PaymentProcessingSpy: PaymentProcessing {
    private(set) var receivedOrder: Order?
    
    func process(order: Order) -> AnyPublisher<Void, any Error> {
        receivedOrder = order
        
        return Result<Void, Error>.success(()).publisher.eraseToAnyPublisher()
    }
}
