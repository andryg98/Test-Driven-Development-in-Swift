//
//  MenuRow.ViewModel.swift
//  Albertos
//
//  Created by Andrea Garau on 27/09/24.
//

import Foundation

extension MenuRow {
    struct ViewModel {
        let text: String
        
        init(item: MenuItem) {
            text = item.spicy ? "\(item.name)🌶" : item.name
        }
    }
}
