//
//  HippoPaymentsProcessor+PaymentProcessing.swift
//  Albertos
//
//  Created by Andrea Garau on 07/10/24.
//

import Combine
import HippoPayments

extension HippoPaymentsProcessor: PaymentProcessing {
    func process(order: Order) -> AnyPublisher<Void, any Error> {
        return Future { promise in
            let payload = try? order.convertToHippoPaymentPayload().asDictionary()
            
            self.processPayment(
                payload: payload ?? [:],
                onSuccess: { promise(.success(())) },
                onFailure: { promise(.failure($0)) }
            )
        }
        .eraseToAnyPublisher()
    }
}
