//
//  PaymentProcessing.swift
//  Albertos
//
//  Created by Andrea Garau on 07/10/24.
//

import Combine

protocol PaymentProcessing {
    func process(order: Order) -> AnyPublisher<Void, Error>
}
