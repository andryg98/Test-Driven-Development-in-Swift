//
//  OrderStoring.swift
//  Albertos
//
//  Created by Andrea Garau on 09/10/24.
//

import Foundation

protocol OrderStoring {
    
    func getOrder() -> Order
    
    func updateOrder(_ order: Order)
    
}
