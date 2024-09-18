//
//  MenuGroupingTests.swift
//  AlbertosTests
//
//  Created by Andrea Garau on 18/09/24.
//

@testable import Albertos
import XCTest

final class MenuGroupingTests: XCTestCase {

    func testMenuWithManyCategoriesReturnsAsManySectionsInReverseAlphabeticalOrder() {
        let menu = [
            MenuItem(category: "pastas", name: "a pasta"),
            MenuItem(category: "drinks", name: "a drink"),
            MenuItem(category: "pastas", name: "another pasta"),
            MenuItem(category: "desserts", name: "a dessert")
        ]
        
        let sections = groupMenuByCategory(menu)
        
        XCTAssertEqual(sections.count, 3)
        XCTAssertEqual(sections[safe: 0]?.category, "desserts")
        XCTAssertEqual(sections[safe: 1]?.category, "drinks")
        XCTAssertEqual(sections[safe: 2]?.category, "pastas")
    }
    
    func testMenuWithOneCategoryReturnsOneSection() throws {
        let menu = [
            MenuItem(category: "pastas", name: "name"),
            MenuItem(category: "pastas", name: "other name")
        ]
        
        let sections = groupMenuByCategory(menu)
        
        XCTAssertEqual(sections.count, 1)
        
        let section = try XCTUnwrap(sections.first)
        
        XCTAssertEqual(section.items.count, 2)
        XCTAssertEqual(section.items.first?.name, "name")
        XCTAssertEqual(section.items.last?.name, "other name")
    }
    
    func testEmptyMenuReturnsEmptySections() {
        let menu = [MenuItem]()
        
        let sections = groupMenuByCategory(menu)
        
        XCTAssertTrue(sections.isEmpty)
    }
}
