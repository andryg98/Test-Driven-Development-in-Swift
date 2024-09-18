//
//  MenuSection.swift
//  Albertos
//
//  Created by Andrea Garau on 18/09/24.
//

import Foundation

struct MenuSection: Identifiable {
    var id: String { category }
    
    let category: String
    let items: [MenuItem]
}
