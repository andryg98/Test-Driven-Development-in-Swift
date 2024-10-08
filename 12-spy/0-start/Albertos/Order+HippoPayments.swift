//
//  Order+HippoPayments.swift
//  Albertos
//
//  Created by Andrea Garau on 07/10/24.
//

import Foundation

extension Order {
    func convertToHippoPaymentPayload() -> HippoPaymentPayload {
        let itemNames = self.items.map(\.name)
        
        return HippoPaymentPayload(items: itemNames)
    }
}
