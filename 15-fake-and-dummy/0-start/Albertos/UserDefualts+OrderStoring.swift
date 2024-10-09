//
//  UserDefualts+OrderStoring.swift
//  Albertos
//
//  Created by Andrea Garau on 09/10/24.
//

import Foundation

extension UserDefaults: OrderStoring {
    
    private var orderKey: String {
        get {
            return "_order"
        }
    }
    
    func getOrder() -> Order {
        if let savedOrderData = self.data(forKey: orderKey) {
            let decoder = JSONDecoder()
            
            if let order = try? decoder.decode(Order.self, from: savedOrderData) {
                return order
            }
        }
        return Order(items: [])
    }
    
    func updateOrder(_ order: Order) {
        let encoder = JSONEncoder()
        if let orderEncoded = try? encoder.encode(order) {
            self.set(orderEncoded, forKey: orderKey)
        }
    }
    
}
