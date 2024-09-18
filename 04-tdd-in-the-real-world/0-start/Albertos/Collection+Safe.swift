//
//  Collection+SAfe.swift
//  Albertos
//
//  Created by Andrea Garau on 18/09/24.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
