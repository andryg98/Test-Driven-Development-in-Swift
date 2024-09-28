//
//  MenuItem+Fixture.swift
//  AlbertosTests
//
//  Created by Andrea Garau on 25/09/24.
//

@testable import Albertos

extension MenuItem {
    static func fixture(
        category: String = "category",
        name: String = "name",
        spicy: Bool = false,
        price: Double = 10.0
    ) -> MenuItem {
        MenuItem(category: category, name: name, spicy: spicy, price: price)
    }
}
