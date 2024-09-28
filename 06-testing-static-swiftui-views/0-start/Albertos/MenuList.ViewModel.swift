//
//  MenuList.ViewModel.swift
//  Albertos
//
//  Created by Andrea Garau on 27/09/24.
//

import Foundation

extension MenuList {
    struct ViewModel {
        let sections: [MenuSection]
        
        init(
            menu: [MenuItem],
            menuGrouping: @escaping ([MenuItem]) -> [MenuSection] = groupMenuByCategory
        ) {
            self.sections = menuGrouping(menu)
        }
    }
}
