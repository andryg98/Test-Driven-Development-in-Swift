//
//  OrderStoringFake.swift
//  AlbertosTests
//
//  Created by Andrea Garau on 09/10/24.
//

@testable import Albertos
import Foundation

class OrderStoringFake: OrderStoring {

    private var order: Order = Order(items: [])
    
    func getOrder() -> Order {
        return order
    }
    
    func updateOrder(_ order: Order) {
        self.order = order
    }
}
