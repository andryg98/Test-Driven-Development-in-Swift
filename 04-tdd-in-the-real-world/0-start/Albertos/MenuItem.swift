//
//  MenuItem.swift
//  Albertos
//
//  Created by Andrea Garau on 18/09/24.
//

import Foundation

struct MenuItem: Identifiable {
    var id: String { name }
    
    let category: String
    let name: String
}

func groupMenuByCategory(_ menu: [MenuItem]) -> [MenuSection] {
    return Dictionary(grouping: menu, by: \.category)
        .map { MenuSection(category: $0.key, items: $0.value) }
        .sorted { $0.category < $1.category }
}
